const std = @import("std");
const spirv = @import("../spirv.zig");
const core = @import("core.zig");

pub const instructions = struct {
    pub fn round(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 1,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn roundEven(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 2,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn trunc(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 3,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn fAbs(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 4,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn sAbs(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 5,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn fSign(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 6,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn sSign(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 7,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn floor(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 8,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn ceil(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 9,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn fract(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 10,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn radians(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 11,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn degrees(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 12,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn sin(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 13,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn cos(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 14,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn tan(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 15,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn asin(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 16,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn acos(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 17,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn atan(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 18,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn sinh(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 19,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn cosh(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 20,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn tanh(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 21,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn asinh(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 22,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn acosh(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 23,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn atanh(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 24,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn atan2(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 25,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn pow(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 26,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn exp(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 27,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn log(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 28,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn exp2(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 29,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn log2(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 30,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn sqrt(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 31,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn inverseSqrt(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 32,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn determinant(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 33,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn matrixInverse(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 34,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn modf(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 35,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn modfStruct(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 36,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn fMin(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 37,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn uMin(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 38,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn sMin(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 39,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn fMax(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 40,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn uMax(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 41,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn sMax(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 42,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn fClamp(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef, arg2: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 43,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn uClamp(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef, arg2: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 44,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn sClamp(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef, arg2: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 45,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn fMix(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef, arg2: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 46,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn iMix(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef, arg2: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 47,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn step(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 48,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn smoothStep(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef, arg2: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 49,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn fma(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef, arg2: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 50,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn frexp(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 51,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn frexpStruct(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 52,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn ldexp(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 53,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn packSnorm4x8(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 54,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn packUnorm4x8(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 55,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn packSnorm2x16(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 56,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn packUnorm2x16(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 57,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn packHalf2x16(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 58,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn packDouble2x32(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 59,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn unpackSnorm2x16(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 60,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn unpackUnorm2x16(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 61,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn unpackHalf2x16(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 62,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn unpackSnorm4x8(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 63,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn unpackUnorm4x8(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 64,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn unpackDouble2x32(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 65,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn length(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 66,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn distance(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 67,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn cross(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 68,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn normalize(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 69,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn faceForward(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef, arg2: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 70,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn reflect(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 71,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn refract(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef, arg2: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 72,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn findILsb(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 73,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn findSMsb(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 74,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn findUMsb(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 75,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn interpolateAtCentroid(self: *spirv.Builder, arg0: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 76,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn interpolateAtSample(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 77,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn interpolateAtOffset(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 78,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn nMin(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 79,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn nMax(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 80,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn nClamp(self: *spirv.Builder, arg0: core.IdRef, arg1: core.IdRef, arg2: core.IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, core.IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 81,
            .operands = operands.toOwnedSlice(),
        });
    }
};
