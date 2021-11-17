const spirv = @import("spirv.zig");

pub const File = []const Decl;
pub const Decl = union(enum) {
    fn_def: FnDef,
    type_def: TypeDef,
    var_def: VarDef,
};

pub const FnDef = struct {
    entry: bool,
    name: Ident,
    args: []const Arg,
    ret: Type,
    body: Block,

    pub const Arg = struct {
        name: Ident,
        type: Type,
    };
};

pub const VarDef = struct {
    constant: bool,
    name: Ident,
    type: Type,
    value: Expr,
};

pub const TypeDef = struct {
    name: Ident,
    type: Type,
};

pub const Ident = []const u8;

pub const Type = union(enum) {
    named: Ident,
    bool: void,
    int: IntType,
    float: FloatType,
    array: *const ArrayType,
    mat: *const MatrixType,
    ref: *const RefType,
    @"struct": *const StructType,
};
pub const IntType = struct {
    signed: bool,
    bits: u64,
};
pub const FloatType = struct {
    bits: u64,
};
pub const ArrayType = struct {
    size: ?u64,
    child: Type,
};
pub const MatrixType = struct {
    size: [2]u3,
    child: Type,
};
pub const RefType = struct {
    kind: union(enum) {
        // TODO: some of these need more info. Also there's probably some missing
        input: u64,
        output: u64,
        uniform: u64,
        uniform_const: u64,
        storage: u64,
        builtin: Builtin,
    },
    child: Type,

    pub const Builtin = spirv.core.BuiltIn;
};
pub const StructType = struct {
    fields: []const Field,
    decls: []const Decl,

    pub const Field = struct {
        name: Ident,
        type: Type,
        default: ?Expr,
    };
};

pub const Stmt = union(enum) {
    assign: Assignment,
    block: Block,
    branch: Branch,
    call: FuncCall,
    control: Control,
    var_def: VarDef,
};

pub const Assignment = struct {
    left: Expr,
    op: ?Binary.Op,
    right: Expr,
};

pub const Block = struct {
    label: ?Ident,
    body: []const Stmt,
};

pub const Branch = union(enum) {
    @"for": For,
    @"if": If,
    @"switch": Switch,
    @"while": While,
};

pub const If = struct {
    expr: Expr,
    body: Expr,
    @"else": ?Expr,
};
pub const Switch = struct {
    expr: Expr,
    cases: []const Case,

    pub const Case = struct {
        expr: Expr,
        then: Expr,
    };
};

pub const For = struct {
    label: ?Ident,
    expr: Expr,
    value: Ident,
    index: ?Ident,
    body: Expr,
    @"else": ?Expr,
};
pub const While = struct {
    label: ?Ident,
    expr: Expr,
    body: Expr,
    @"else": ?Expr,
};

pub const Control = union(enum) {
    @"break": ?Expr,
    @"continue": void,
    @"return": ?Expr,
};

pub const Expr = union(enum) {
    block: *const Block,
    call: *const FuncCall,
    branch: *const Branch,
    unary: *const Unary,
    binary: *const Binary,
};

pub const FuncCall = struct {
    callee: Expr,
    args: []const Expr,
};

pub const Unary = struct {
    op: Op,
    expr: *const Expr,

    pub const Op = enum {
        not,
        invert,
    };
};

pub const Binary = struct {
    left: Expr,
    op: Op,
    right: Expr,

    pub const Op = enum {
        add,
        sub,
        mult,
        div,
        mod,

        lsh,
        rsh,
        @"and",
        @"or",

        eq,
        gt,
        lt,
        ge,
        le,
    };
};

test {
    @import("std").testing.refAllDecls(@This());
}
