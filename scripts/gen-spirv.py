#!/usr/bin/env python3
import json
import os
import re
import requests
import string
import subprocess
import sys
from dataclasses import dataclass

CORE_URL = "https://github.com/KhronosGroup/SPIRV-Headers/raw/master/include/spirv/1.0/spirv.core.grammar.json"
GLSL_URL = "https://github.com/KhronosGroup/SPIRV-Headers/raw/master/include/spirv/1.0/extinst.glsl.std.450.grammar.json"

NORMALIZE_WORDS = (
    # Acronyms
    "AMD ESSL EXT GOOGLE GLSL GL HLSL INTEL IO KHR NV OpenCL _C _CPP".split()
    # Color modes
    + "ABGR ARGB BGRA RA RG RGB RGBA sARGB sBGRA sRGB sRGBA".split()
    # Float stuff
    + "FP NSZ NaN RTE RTN RTP RTZ".split()
    # Dimensions
    + "1D 2D 3D".split()
    # Misc
    + ["MS"]
)
NORMALIZE_WORDS_RE = re.compile(
    "|".join(map(re.escape, sorted(NORMALIZE_WORDS, key=len, reverse=True)))
)


def normalize_words(s):
    return NORMALIZE_WORDS_RE.sub(lambda m: m.group(0).capitalize(), s)


TO_SNAKE_CASE = str.maketrans(
    {
        upper: "_" + lower
        for upper, lower in zip(string.ascii_uppercase, string.ascii_lowercase)
    }
)


def to_snake_case(s):
    s = normalize_words(s)
    return s.translate(TO_SNAKE_CASE).lstrip("_")


def to_camel_case(s):
    s = normalize_words(s)
    return s[0].lower() + s[1:]


# Print the string as a Zig identifier escaping it with @"" syntax if needed.
# Ported from std/zig/fmt.zig
def format_id(name):
    if is_valid_id(name):
        return name
    else:
        return f"@{json.dumps(name)}"  # JSON strings are close enough and I'm lazy


ZIG_KEYWORDS = """
    addrspace align allowzero and anyframe anytype asm async await break
    callconv catch comptime const continue defer else enum errdefer error
    export extern fn for if inline noalias noinline nosuspend opaque or
    orelse packed pub resume return linksection struct suspend switch test
    threadlocal try union unreachable usingnamespace var volatile while
""".split()


def is_valid_id(name):
    if name == "_":
        return False
    for i, c in enumerate(name):
        if c.isalpha() or c == "_":
            pass
        elif c.isdigit():
            if i == 0:
                return False
        else:
            return False
    return name not in ZIG_KEYWORDS


class BaseType:
    def __init__(self, spec):
        self.name = spec["kind"]
        self.doc = spec.get("doc")

    def type_def(self):
        s = f"pub const {self.name}"
        if self.doc is not None:
            s = f"/// {self.doc}\n" + s
        return s


class EnumType(BaseType):
    def __init__(self, spec):
        super().__init__(spec)
        self.fields = []
        self.duplicate_fields = []
        values = {}
        for field in spec["enumerants"]:
            params = [p["kind"] for p in field.get("parameters", [])]
            name = format_id(to_snake_case(field["enumerant"]))
            value = field["value"]
            if isinstance(value, str):
                value = int(value, 0)
            f = EnumType.Field(name, value, params)
            if value in values:
                assert values[value].params == f.params
                self.duplicate_fields.append(f)
            else:
                self.fields.append(f)
                values[value] = f

    @dataclass
    class Field:
        name: str
        value: int
        params: list


class BitEnumType(EnumType):
    def zig_type(self):
        lines = [f"{self.type_def()} = packed struct {{"]

        for field in self.fields:
            if field.value == 0:
                continue
            if not field.params:
                lines.append(f"{field.name}: bool = false,")
            elif len(field.params) == 1:
                lines.append(f"{field.name}: ?{field.params[0]} = null,")
            else:
                param_types = ", ".join(field.params)
                lines.append(f"{field.name}: ?std.meta.Tuple({param_types}) = null,")
        lines.append("")

        lines.append(f"pub fn bitmask(self: {self.name}) u32 {{")
        lines.append("var bits: u32 = 0;")
        for field in self.fields:
            if field.value == 0:
                continue
            cond = " != null" if field.params else ""
            lines.append(f"if (self.{field.name}{cond}) bits |= 0x{field.value:x};")
        lines.append("return bits;")
        lines.append("}")

        lines.append("};")
        return "\n".join(lines)


class ValueEnumType(EnumType):
    def zig_type(self):
        use_union = any(field.params for field in self.fields)
        lines = [f"{self.type_def()} = "]
        if use_union:
            lines[-1] += f"union({self.name}Tag) {{"
            for field in self.fields:
                if not field.params:
                    lines.append(f"{field.name}: void,")
                elif len(field.params) == 1:
                    lines.append(f"{field.name}: {field.params[0]},")
                else:
                    param_types = ", ".join(field.params)
                    lines.append(f"{field.name}: std.meta.Tuple({param_types}),")
            lines.append("};")
            lines.append(f"pub const {self.name}Tag = ")

        lines[-1] += "enum(u16) {"
        for field in self.fields:
            lines.append(f"{field.name} = {field.value},")
        lines.append("};")

        return "\n".join(lines)


class IdType(BaseType):
    def zig_type(self):
        return f"{self.type_def()} = spirv.Id;"


class LiteralType(BaseType):
    def __init__(self, spec):
        super().__init__(spec)

    def zig_type(self):
        if self.name == "LiteralInteger":
            ty = "u64"
        elif self.name == "LiteralString":
            ty = "[]const u8"
        else:
            ty = '@compileError("TODO")'
        return f"{self.type_def()} = {ty};"


class CompositeType(BaseType):
    def __init__(self, spec):
        super().__init__(spec)
        self.bases = spec["bases"]

    def zig_type(self):
        return f'{self.type_def()} = std.meta.Tuple(&.{{ {", ".join(self.bases)} }});'


TYPE_CATEGORIES = {
    "BitEnum": BitEnumType,
    "ValueEnum": ValueEnumType,
    "Id": IdType,
    "Literal": LiteralType,
    "Composite": CompositeType,
}


def gen(url, f, core=True):
    f.write('const std = @import("std");\n')
    f.write('const spirv = @import("../spirv.zig");\n')

    spec = requests.get(url).json()
    if core:
        f.write("\n")
        f.write(f'pub const magic_number = {spec["magic_number"]};\n')
        f.write(
            f'pub const version = ({spec["major_version"]} << 16) | ({spec["minor_version"]} << 8);\n'
        )
    else:
        f.write('const core = @import("core.zig");\n')
    f.write("\n")

    types = {}
    for type_spec in spec.get("operand_kinds", []):
        cls = TYPE_CATEGORIES[type_spec["category"]]
        types[type_spec["kind"]] = cls(type_spec)

    f.write("pub const instructions = struct {\n")
    for insn in spec["instructions"]:
        name = insn["opname"]
        if name.startswith("Op"):
            name = name[2:]
        name = format_id(to_camel_case(name))

        operands = insn.get("operands", [])
        has_type = operands and operands[0]["kind"] == "IdResultType"
        if has_type:
            operands = operands[1:]
        has_result = operands and operands[0]["kind"] == "IdResult"
        if has_result:
            operands = operands[1:]

        for i, op in enumerate(operands):
            ty = op["kind"]
            if (not core) and (ty not in types):
                ty = "core." + ty
            if op.get("quantifier") == "?":
                ty = "?" + ty
            elif op.get("quantifier") == "*":
                ty = "[]const " + ty
            operands[i] = ty

        f.write(f"pub fn {name}(self: *spirv.Builder")
        if has_type:
            f.write(", result_type: spirv.Id")
        for i, ty in enumerate(operands):
            f.write(f", arg{i}: {ty}")
        f.write(") !")
        if has_result:
            f.write("spirv.Id {\n")
            f.write("const result = self.newId();\n")
        else:
            f.write("void {\n")

        f.write("var operands = std.ArrayList(spirv.Operand).init(self.allocator);\n")
        f.write("errdefer operands.deinit();\n")
        if has_type:
            f.write(
                "try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);\n"
            )
        if has_result:
            f.write("try spirv.Builder.writeOperand(&operands, spirv.Id, result);\n")

        for i, ty in enumerate(operands):
            f.write(f"try spirv.Builder.writeOperand(&operands, {ty}, arg{i});\n")

        f.write("try self.insns.append(self.allocator, .{\n")
        f.write(f'.op = {insn["opcode"]},\n')
        f.write(".operands = operands.toOwnedSlice(),\n")
        f.write("});\n")
        if has_result:
            f.write("return result;\n")
        f.write("}\n\n")
    f.write("};\n\n")

    for ty in types.values():
        f.write(ty.zig_type())
        f.write("\n\n")


if __name__ == "__main__":
    os.chdir(os.path.join(os.path.dirname(sys.argv[0]), "..", "src", "gen"))
    with open("core.zig", "w") as f:
        gen(CORE_URL, f)
    with open("glsl.zig", "w") as f:
        gen(GLSL_URL, f, core=False)
    subprocess.call(["zig", "fmt", "."], stdout=subprocess.DEVNULL)
