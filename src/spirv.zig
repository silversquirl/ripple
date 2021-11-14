const std = @import("std");
const core = @import("gen/core.zig");

pub const Builder = struct {
    allocator: *std.mem.Allocator,
    id_count: u32 = 0,
    insns: std.ArrayListUnmanaged(Instruction) = .{},

    pub fn init(allocator: *std.mem.Allocator) Builder {
        return .{ .allocator = allocator };
    }
    pub fn deinit(self: *Builder) void {
        for (self.insns.items) |insn| {
            self.allocator.free(insn.operands);
        }
        self.insns.deinit(self.allocator);
    }

    pub fn newId(self: *Builder) Id {
        self.id_count += 1;
        return Id{ .n = self.id_count };
    }

    pub fn writeOperand(operands: *std.ArrayList(Operand), comptime T: type, v: T) !void {
        switch (T) {
            Id => return operands.append(.{ .id = v }),
            u64 => return operands.append(.{ .int = v }),
            []const u8 => return operands.append(.{ .str = v }),
            else => {},
        }

        if (comptime std.meta.trait.isTuple(T)) {
            inline for (std.meta.fields(T)) |field| {
                try writeOperand(operands, field.field_type, @field(v, field.name));
            }
            return;
        }

        if (comptime std.meta.trait.isSlice(T)) {
            for (v) |v_val| {
                try writeOperand(v_val);
            }
        }

        switch (@typeInfo(T)) {
            .Optional => if (v) |v_val| {
                try writeOperand(v_val);
            },
            .Enum => return operands.append(.{ .int = @enumToInt(v) }),

            .Union => {
                try operands.append(.{ .int = @enumToInt(v) });
                inline for (std.meta.fields(T)) |field| {
                    if (field.field_type == void) continue;
                    if (v == @field(std.meta.Tag(T), field.name)) {
                        try writeOperand(operands, field.field_type, @field(v, field.name));
                    }
                }
                return;
            },

            .Struct => {
                try operands.append(.{ .int = v.bitmask() });
                inline for (std.meta.fields(T)) |field| {
                    if (field.field_type == bool) continue;
                    if (@field(v, field.name)) |field_value| {
                        try writeOperand(operands, std.meta.Child(field.field_type), field_value);
                    }
                }
                return;
            },

            else => @compileError("Cannot handle type '" ++ @typeName(T) ++ "'"),
        }
    }

    pub usingnamespace core.instructions;

    pub fn build(self: Builder, buf: *std.ArrayList(u32)) !void {
        try buf.append(core.magic_number); // Magic
        try buf.append(core.version); // Version
        try buf.append(0); // Generator - TODO: if/when Ripple actually works, consider registering a magic number
        try buf.append(self.id_count + 1); // Bound - this number is greater than the largest ID
        try buf.append(0); // Reserved

        for (self.insns.items) |insn| {
            var nbyte: u16 = 1;
            for (insn.operands) |op| {
                nbyte += op.len();
            }

            const start = buf.items.len;
            try buf.append(@as(u32, nbyte) << 16 | insn.op);
            for (insn.operands) |op| {
                try op.write(buf);
            }

            std.debug.assert(buf.items.len - start == nbyte);
        }
    }
};

pub const Instruction = struct {
    op: u16,
    operands: []const Operand = &.{},
};

pub const Operand = union(enum) {
    id: Id,
    int: u64,
    str: []const u8,

    pub fn len(self: Operand) u16 {
        return switch (self) {
            .id => 1,
            .int => |int| @as(u16, 1) + @boolToInt(int >> 32 != 0), // FIXME: no clue if this is right
            .str => |str| @intCast(u16, ceilToMultiple(str.len + 1, 4)),
        };
    }
    /// Returns the lowest multiple of `a` which is >= `x`. `a` must be a power of 2.
    fn ceilToMultiple(x: usize, a: u29) usize {
        std.debug.assert(std.math.isPowerOfTwo(a));
        return ~((~x + 1) & (~@as(usize, a) + 1)) + 1;
    }

    pub fn write(self: Operand, buf: *std.ArrayList(u32)) !void {
        switch (self) {
            .id => |id| try buf.append(id.n),

            .int => |int| {
                // FIXME: no clue if this is right
                try buf.append(@truncate(u32, int));
                if (int >> 32 != 0) {
                    try buf.append(@truncate(u32, int >> 32));
                }
            },

            .str => |str| {
                var word: u32 = 0;
                for (str) |c, i| {
                    word = @shlExact(word, 8);
                    word |= c;
                    if (i % 4 == 3) {
                        try buf.append(word);
                        word = 0;
                    }
                }
                try buf.append(word); // Write any remaining bytes, followed by the 0 sentinel
            },
        }
    }
};

pub const Id = struct { n: u32 };

test "SPIR-V generation" {
    var b = Builder.init(std.testing.allocator);
    defer b.deinit();

    try b.capability(.shader);

    var buf = std.ArrayList(u32).init(std.testing.allocator);
    defer buf.deinit();
    try b.build(&buf);

    try std.testing.expectEqualSlices(u32, &.{
        // Header
        core.magic_number,
        core.version,
        0,
        1,
        0,

        // OpCapability Shader
        0x0002_0011,
        1,
    }, buf.items);
}
