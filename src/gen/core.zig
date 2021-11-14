const std = @import("std");
const spirv = @import("../spirv.zig");
pub const magic_number = 0x07230203;
pub const version = (1 << 16) | (0 << 8);

pub const instructions = struct {
    pub fn nop(self: *spirv.Builder) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try self.insns.append(self.allocator, .{
            .op = 0,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn undef(self: *spirv.Builder, result_type: spirv.Id) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 1,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn source_continued(self: *spirv.Builder, arg0: LiteralString) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, LiteralString, arg0);
        try self.insns.append(self.allocator, .{
            .op = 2,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn source(self: *spirv.Builder, arg0: SourceLanguage, arg1: LiteralInteger, arg2: ?IdRef, arg3: ?LiteralString) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, SourceLanguage, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, LiteralString, arg3);
        try self.insns.append(self.allocator, .{
            .op = 3,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn source_extension(self: *spirv.Builder, arg0: LiteralString) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, LiteralString, arg0);
        try self.insns.append(self.allocator, .{
            .op = 4,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn name(self: *spirv.Builder, arg0: IdRef, arg1: LiteralString) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralString, arg1);
        try self.insns.append(self.allocator, .{
            .op = 5,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn member_name(self: *spirv.Builder, arg0: IdRef, arg1: LiteralInteger, arg2: LiteralString) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg1);
        try spirv.Builder.writeOperand(&operands, LiteralString, arg2);
        try self.insns.append(self.allocator, .{
            .op = 6,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn string(self: *spirv.Builder, arg0: LiteralString) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, LiteralString, arg0);
        try self.insns.append(self.allocator, .{
            .op = 7,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn line(self: *spirv.Builder, arg0: IdRef, arg1: LiteralInteger, arg2: LiteralInteger) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg1);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg2);
        try self.insns.append(self.allocator, .{
            .op = 8,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn extension(self: *spirv.Builder, arg0: LiteralString) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, LiteralString, arg0);
        try self.insns.append(self.allocator, .{
            .op = 10,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn ext_inst_import(self: *spirv.Builder, arg0: LiteralString) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, LiteralString, arg0);
        try self.insns.append(self.allocator, .{
            .op = 11,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn ext_inst(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: LiteralExtInstInteger, arg2: []const IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralExtInstInteger, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 12,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn memory_model(self: *spirv.Builder, arg0: AddressingModel, arg1: MemoryModel) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, AddressingModel, arg0);
        try spirv.Builder.writeOperand(&operands, MemoryModel, arg1);
        try self.insns.append(self.allocator, .{
            .op = 14,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn entry_point(self: *spirv.Builder, arg0: ExecutionModel, arg1: IdRef, arg2: LiteralString, arg3: []const IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, ExecutionModel, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, LiteralString, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 15,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn execution_mode(self: *spirv.Builder, arg0: IdRef, arg1: ExecutionMode) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, ExecutionMode, arg1);
        try self.insns.append(self.allocator, .{
            .op = 16,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn capability(self: *spirv.Builder, arg0: Capability) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, Capability, arg0);
        try self.insns.append(self.allocator, .{
            .op = 17,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn type_void(self: *spirv.Builder) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 19,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_bool(self: *spirv.Builder) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 20,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_int(self: *spirv.Builder, arg0: LiteralInteger, arg1: LiteralInteger) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg1);
        try self.insns.append(self.allocator, .{
            .op = 21,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_float(self: *spirv.Builder, arg0: LiteralInteger) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg0);
        try self.insns.append(self.allocator, .{
            .op = 22,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_vector(self: *spirv.Builder, arg0: IdRef, arg1: LiteralInteger) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg1);
        try self.insns.append(self.allocator, .{
            .op = 23,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_matrix(self: *spirv.Builder, arg0: IdRef, arg1: LiteralInteger) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg1);
        try self.insns.append(self.allocator, .{
            .op = 24,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_image(self: *spirv.Builder, arg0: IdRef, arg1: Dim, arg2: LiteralInteger, arg3: LiteralInteger, arg4: LiteralInteger, arg5: LiteralInteger, arg6: ImageFormat, arg7: ?AccessQualifier) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, Dim, arg1);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg2);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg3);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg4);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg5);
        try spirv.Builder.writeOperand(&operands, ImageFormat, arg6);
        try spirv.Builder.writeOperand(&operands, AccessQualifier, arg7);
        try self.insns.append(self.allocator, .{
            .op = 25,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_sampler(self: *spirv.Builder) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 26,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_sampled_image(self: *spirv.Builder, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 27,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_array(self: *spirv.Builder, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 28,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_runtime_array(self: *spirv.Builder, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 29,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_struct(self: *spirv.Builder, arg0: []const IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 30,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_opaque(self: *spirv.Builder, arg0: LiteralString) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, LiteralString, arg0);
        try self.insns.append(self.allocator, .{
            .op = 31,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_pointer(self: *spirv.Builder, arg0: StorageClass, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, StorageClass, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 32,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_function(self: *spirv.Builder, arg0: IdRef, arg1: []const IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 33,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_event(self: *spirv.Builder) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 34,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_device_event(self: *spirv.Builder) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 35,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_reserve_id(self: *spirv.Builder) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 36,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_queue(self: *spirv.Builder) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 37,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_pipe(self: *spirv.Builder, arg0: AccessQualifier) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, AccessQualifier, arg0);
        try self.insns.append(self.allocator, .{
            .op = 38,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn type_forward_pointer(self: *spirv.Builder, arg0: IdRef, arg1: StorageClass) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, StorageClass, arg1);
        try self.insns.append(self.allocator, .{
            .op = 39,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn constant_true(self: *spirv.Builder, result_type: spirv.Id) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 41,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn constant_false(self: *spirv.Builder, result_type: spirv.Id) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 42,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn constant(self: *spirv.Builder, result_type: spirv.Id, arg0: LiteralContextDependentNumber) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, LiteralContextDependentNumber, arg0);
        try self.insns.append(self.allocator, .{
            .op = 43,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn constant_composite(self: *spirv.Builder, result_type: spirv.Id, arg0: []const IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 44,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn constant_sampler(self: *spirv.Builder, result_type: spirv.Id, arg0: SamplerAddressingMode, arg1: LiteralInteger, arg2: SamplerFilterMode) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, SamplerAddressingMode, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg1);
        try spirv.Builder.writeOperand(&operands, SamplerFilterMode, arg2);
        try self.insns.append(self.allocator, .{
            .op = 45,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn constant_null(self: *spirv.Builder, result_type: spirv.Id) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 46,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn spec_constant_true(self: *spirv.Builder, result_type: spirv.Id) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 48,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn spec_constant_false(self: *spirv.Builder, result_type: spirv.Id) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 49,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn spec_constant(self: *spirv.Builder, result_type: spirv.Id, arg0: LiteralContextDependentNumber) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, LiteralContextDependentNumber, arg0);
        try self.insns.append(self.allocator, .{
            .op = 50,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn spec_constant_composite(self: *spirv.Builder, result_type: spirv.Id, arg0: []const IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 51,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn spec_constant_op(self: *spirv.Builder, result_type: spirv.Id, arg0: LiteralSpecConstantOpInteger) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, LiteralSpecConstantOpInteger, arg0);
        try self.insns.append(self.allocator, .{
            .op = 52,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn function(self: *spirv.Builder, result_type: spirv.Id, arg0: FunctionControl, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, FunctionControl, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 54,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn function_parameter(self: *spirv.Builder, result_type: spirv.Id) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 55,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn function_end(self: *spirv.Builder) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try self.insns.append(self.allocator, .{
            .op = 56,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn function_call(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: []const IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 57,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn variable(self: *spirv.Builder, result_type: spirv.Id, arg0: StorageClass, arg1: ?IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, StorageClass, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 59,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_texel_pointer(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 60,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn load(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: ?MemoryAccess) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, MemoryAccess, arg1);
        try self.insns.append(self.allocator, .{
            .op = 61,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn store(self: *spirv.Builder, arg0: IdRef, arg1: IdRef, arg2: ?MemoryAccess) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, MemoryAccess, arg2);
        try self.insns.append(self.allocator, .{
            .op = 62,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn copy_memory(self: *spirv.Builder, arg0: IdRef, arg1: IdRef, arg2: ?MemoryAccess) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, MemoryAccess, arg2);
        try self.insns.append(self.allocator, .{
            .op = 63,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn copy_memory_sized(self: *spirv.Builder, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: ?MemoryAccess) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, MemoryAccess, arg3);
        try self.insns.append(self.allocator, .{
            .op = 64,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn access_chain(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: []const IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 65,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn in_bounds_access_chain(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: []const IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 66,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn ptr_access_chain(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: []const IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 67,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn array_length(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: LiteralInteger) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg1);
        try self.insns.append(self.allocator, .{
            .op = 68,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn generic_ptr_mem_semantics(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 69,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn in_bounds_ptr_access_chain(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: []const IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 70,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn decorate(self: *spirv.Builder, arg0: IdRef, arg1: Decoration) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, Decoration, arg1);
        try self.insns.append(self.allocator, .{
            .op = 71,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn member_decorate(self: *spirv.Builder, arg0: IdRef, arg1: LiteralInteger, arg2: Decoration) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg1);
        try spirv.Builder.writeOperand(&operands, Decoration, arg2);
        try self.insns.append(self.allocator, .{
            .op = 72,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn decoration_group(self: *spirv.Builder) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 73,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_decorate(self: *spirv.Builder, arg0: IdRef, arg1: []const IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 74,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn group_member_decorate(self: *spirv.Builder, arg0: IdRef, arg1: []const PairIdRefLiteralInteger) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, PairIdRefLiteralInteger, arg1);
        try self.insns.append(self.allocator, .{
            .op = 75,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn vector_extract_dynamic(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 77,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn vector_insert_dynamic(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 78,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn vector_shuffle(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: []const LiteralInteger) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg2);
        try self.insns.append(self.allocator, .{
            .op = 79,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn composite_construct(self: *spirv.Builder, result_type: spirv.Id, arg0: []const IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 80,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn composite_extract(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: []const LiteralInteger) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg1);
        try self.insns.append(self.allocator, .{
            .op = 81,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn composite_insert(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: []const LiteralInteger) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg2);
        try self.insns.append(self.allocator, .{
            .op = 82,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn copy_object(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 83,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn transpose(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 84,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn sampled_image(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 86,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sample_implicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg2);
        try self.insns.append(self.allocator, .{
            .op = 87,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sample_explicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg2);
        try self.insns.append(self.allocator, .{
            .op = 88,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sample_dref_implicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg3);
        try self.insns.append(self.allocator, .{
            .op = 89,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sample_dref_explicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg3);
        try self.insns.append(self.allocator, .{
            .op = 90,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sample_proj_implicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg2);
        try self.insns.append(self.allocator, .{
            .op = 91,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sample_proj_explicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg2);
        try self.insns.append(self.allocator, .{
            .op = 92,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sample_proj_dref_implicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg3);
        try self.insns.append(self.allocator, .{
            .op = 93,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sample_proj_dref_explicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg3);
        try self.insns.append(self.allocator, .{
            .op = 94,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_fetch(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg2);
        try self.insns.append(self.allocator, .{
            .op = 95,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_gather(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg3);
        try self.insns.append(self.allocator, .{
            .op = 96,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_dref_gather(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg3);
        try self.insns.append(self.allocator, .{
            .op = 97,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_read(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg2);
        try self.insns.append(self.allocator, .{
            .op = 98,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_write(self: *spirv.Builder, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: ?ImageOperands) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg3);
        try self.insns.append(self.allocator, .{
            .op = 99,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn image(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 100,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_query_format(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 101,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_query_order(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 102,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_query_size_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 103,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_query_size(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 104,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_query_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 105,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_query_levels(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 106,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_query_samples(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 107,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn convert_f_to_u(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 109,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn convert_f_to_s(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 110,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn convert_s_to_f(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 111,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn convert_u_to_f(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 112,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn u_convert(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 113,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn s_convert(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 114,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_convert(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 115,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn quantize_to_f16(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 116,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn convert_ptr_to_u(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 117,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn sat_convert_s_to_u(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 118,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn sat_convert_u_to_s(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 119,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn convert_u_to_ptr(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 120,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn ptr_cast_to_generic(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 121,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn generic_cast_to_ptr(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 122,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn generic_cast_to_ptr_explicit(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: StorageClass) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, StorageClass, arg1);
        try self.insns.append(self.allocator, .{
            .op = 123,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn bitcast(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 124,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn s_negate(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 126,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_negate(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 127,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn i_add(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 128,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_add(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 129,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn i_sub(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 130,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_sub(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 131,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn i_mul(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 132,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_mul(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 133,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn u_div(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 134,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn s_div(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 135,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_div(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 136,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn u_mod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 137,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn s_rem(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 138,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn s_mod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 139,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_rem(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 140,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_mod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 141,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn vector_times_scalar(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 142,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn matrix_times_scalar(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 143,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn vector_times_matrix(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 144,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn matrix_times_vector(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 145,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn matrix_times_matrix(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 146,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn outer_product(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 147,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn dot(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 148,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn i_add_carry(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 149,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn i_sub_borrow(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 150,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn u_mul_extended(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 151,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn s_mul_extended(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 152,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn any(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 154,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn all(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 155,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn is_nan(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 156,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn is_inf(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 157,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn is_finite(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 158,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn is_normal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 159,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn sign_bit_set(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 160,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn less_or_greater(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 161,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn ordered(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 162,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn unordered(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 163,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn logical_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 164,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn logical_not_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 165,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn logical_or(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 166,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn logical_and(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 167,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn logical_not(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 168,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn select(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 169,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn i_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 170,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn i_not_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 171,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn u_greater_than(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 172,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn s_greater_than(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 173,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn u_greater_than_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 174,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn s_greater_than_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 175,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn u_less_than(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 176,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn s_less_than(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 177,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn u_less_than_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 178,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn s_less_than_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 179,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_ord_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 180,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_unord_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 181,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_ord_not_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 182,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_unord_not_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 183,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_ord_less_than(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 184,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_unord_less_than(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 185,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_ord_greater_than(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 186,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_unord_greater_than(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 187,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_ord_less_than_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 188,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_unord_less_than_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 189,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_ord_greater_than_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 190,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn f_unord_greater_than_equal(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 191,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn shift_right_logical(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 194,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn shift_right_arithmetic(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 195,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn shift_left_logical(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 196,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn bitwise_or(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 197,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn bitwise_xor(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 198,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn bitwise_and(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 199,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn not(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 200,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn bit_field_insert(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 201,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn bit_field_s_extract(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 202,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn bit_field_u_extract(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 203,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn bit_reverse(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 204,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn bit_count(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 205,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn d_pdx(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 207,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn d_pdy(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 208,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn fwidth(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 209,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn d_pdx_fine(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 210,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn d_pdy_fine(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 211,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn fwidth_fine(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 212,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn d_pdx_coarse(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 213,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn d_pdy_coarse(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 214,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn fwidth_coarse(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 215,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn emit_vertex(self: *spirv.Builder) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try self.insns.append(self.allocator, .{
            .op = 218,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn end_primitive(self: *spirv.Builder) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try self.insns.append(self.allocator, .{
            .op = 219,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn emit_stream_vertex(self: *spirv.Builder, arg0: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 220,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn end_stream_primitive(self: *spirv.Builder, arg0: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 221,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn control_barrier(self: *spirv.Builder, arg0: IdScope, arg1: IdScope, arg2: IdMemorySemantics) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try self.insns.append(self.allocator, .{
            .op = 224,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn memory_barrier(self: *spirv.Builder, arg0: IdScope, arg1: IdMemorySemantics) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg1);
        try self.insns.append(self.allocator, .{
            .op = 225,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn atomic_load(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try self.insns.append(self.allocator, .{
            .op = 227,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_store(self: *spirv.Builder, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics, arg3: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 228,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn atomic_exchange(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 229,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_compare_exchange(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics, arg3: IdMemorySemantics, arg4: IdRef, arg5: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg3);
        try spirv.Builder.writeOperand(&operands, IdRef, arg4);
        try spirv.Builder.writeOperand(&operands, IdRef, arg5);
        try self.insns.append(self.allocator, .{
            .op = 230,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_compare_exchange_weak(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics, arg3: IdMemorySemantics, arg4: IdRef, arg5: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg3);
        try spirv.Builder.writeOperand(&operands, IdRef, arg4);
        try spirv.Builder.writeOperand(&operands, IdRef, arg5);
        try self.insns.append(self.allocator, .{
            .op = 231,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_i_increment(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try self.insns.append(self.allocator, .{
            .op = 232,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_i_decrement(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try self.insns.append(self.allocator, .{
            .op = 233,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_i_add(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 234,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_i_sub(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 235,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_s_min(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 236,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_u_min(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 237,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_s_max(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 238,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_u_max(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 239,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_and(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 240,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_or(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 241,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_xor(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 242,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn phi(self: *spirv.Builder, result_type: spirv.Id, arg0: []const PairIdRefIdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, PairIdRefIdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 245,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn loop_merge(self: *spirv.Builder, arg0: IdRef, arg1: IdRef, arg2: LoopControl) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, LoopControl, arg2);
        try self.insns.append(self.allocator, .{
            .op = 246,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn selection_merge(self: *spirv.Builder, arg0: IdRef, arg1: SelectionControl) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, SelectionControl, arg1);
        try self.insns.append(self.allocator, .{
            .op = 247,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn label(self: *spirv.Builder) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 248,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn branch(self: *spirv.Builder, arg0: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 249,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn branch_conditional(self: *spirv.Builder, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: []const LiteralInteger) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg3);
        try self.insns.append(self.allocator, .{
            .op = 250,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn @"switch"(self: *spirv.Builder, arg0: IdRef, arg1: IdRef, arg2: []const PairLiteralIntegerIdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, PairLiteralIntegerIdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 251,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn kill(self: *spirv.Builder) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try self.insns.append(self.allocator, .{
            .op = 252,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn @"return"(self: *spirv.Builder) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try self.insns.append(self.allocator, .{
            .op = 253,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn return_value(self: *spirv.Builder, arg0: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 254,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn @"unreachable"(self: *spirv.Builder) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try self.insns.append(self.allocator, .{
            .op = 255,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn lifetime_start(self: *spirv.Builder, arg0: IdRef, arg1: LiteralInteger) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg1);
        try self.insns.append(self.allocator, .{
            .op = 256,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn lifetime_stop(self: *spirv.Builder, arg0: IdRef, arg1: LiteralInteger) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg1);
        try self.insns.append(self.allocator, .{
            .op = 257,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn group_async_copy(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: IdRef, arg2: IdRef, arg3: IdRef, arg4: IdRef, arg5: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try spirv.Builder.writeOperand(&operands, IdRef, arg4);
        try spirv.Builder.writeOperand(&operands, IdRef, arg5);
        try self.insns.append(self.allocator, .{
            .op = 259,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_wait_events(self: *spirv.Builder, arg0: IdScope, arg1: IdRef, arg2: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 260,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn group_all(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 261,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_any(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 262,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_broadcast(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: IdRef, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 263,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_i_add(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 264,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_f_add(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 265,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_f_min(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 266,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_u_min(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 267,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_s_min(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 268,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_f_max(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 269,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_u_max(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 270,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_s_max(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 271,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn read_pipe(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 274,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn write_pipe(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 275,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn reserved_read_pipe(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef, arg4: IdRef, arg5: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try spirv.Builder.writeOperand(&operands, IdRef, arg4);
        try spirv.Builder.writeOperand(&operands, IdRef, arg5);
        try self.insns.append(self.allocator, .{
            .op = 276,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn reserved_write_pipe(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef, arg4: IdRef, arg5: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try spirv.Builder.writeOperand(&operands, IdRef, arg4);
        try spirv.Builder.writeOperand(&operands, IdRef, arg5);
        try self.insns.append(self.allocator, .{
            .op = 277,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn reserve_read_pipe_packets(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 278,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn reserve_write_pipe_packets(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 279,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn commit_read_pipe(self: *spirv.Builder, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 280,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn commit_write_pipe(self: *spirv.Builder, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 281,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn is_valid_reserve_id(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 282,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn get_num_pipe_packets(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 283,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn get_max_pipe_packets(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 284,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_reserve_read_pipe_packets(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: IdRef, arg2: IdRef, arg3: IdRef, arg4: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try spirv.Builder.writeOperand(&operands, IdRef, arg4);
        try self.insns.append(self.allocator, .{
            .op = 285,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_reserve_write_pipe_packets(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: IdRef, arg2: IdRef, arg3: IdRef, arg4: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try spirv.Builder.writeOperand(&operands, IdRef, arg4);
        try self.insns.append(self.allocator, .{
            .op = 286,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_commit_read_pipe(self: *spirv.Builder, arg0: IdScope, arg1: IdRef, arg2: IdRef, arg3: IdRef, arg4: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try spirv.Builder.writeOperand(&operands, IdRef, arg4);
        try self.insns.append(self.allocator, .{
            .op = 287,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn group_commit_write_pipe(self: *spirv.Builder, arg0: IdScope, arg1: IdRef, arg2: IdRef, arg3: IdRef, arg4: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try spirv.Builder.writeOperand(&operands, IdRef, arg4);
        try self.insns.append(self.allocator, .{
            .op = 288,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn enqueue_marker(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 291,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn enqueue_kernel(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef, arg4: IdRef, arg5: IdRef, arg6: IdRef, arg7: IdRef, arg8: IdRef, arg9: IdRef, arg10: []const IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try spirv.Builder.writeOperand(&operands, IdRef, arg4);
        try spirv.Builder.writeOperand(&operands, IdRef, arg5);
        try spirv.Builder.writeOperand(&operands, IdRef, arg6);
        try spirv.Builder.writeOperand(&operands, IdRef, arg7);
        try spirv.Builder.writeOperand(&operands, IdRef, arg8);
        try spirv.Builder.writeOperand(&operands, IdRef, arg9);
        try spirv.Builder.writeOperand(&operands, IdRef, arg10);
        try self.insns.append(self.allocator, .{
            .op = 292,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn get_kernel_n_drange_sub_group_count(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef, arg4: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try spirv.Builder.writeOperand(&operands, IdRef, arg4);
        try self.insns.append(self.allocator, .{
            .op = 293,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn get_kernel_n_drange_max_sub_group_size(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef, arg4: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try spirv.Builder.writeOperand(&operands, IdRef, arg4);
        try self.insns.append(self.allocator, .{
            .op = 294,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn get_kernel_work_group_size(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 295,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn get_kernel_preferred_work_group_size_multiple(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, IdRef, arg3);
        try self.insns.append(self.allocator, .{
            .op = 296,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn retain_event(self: *spirv.Builder, arg0: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 297,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn release_event(self: *spirv.Builder, arg0: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 298,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn create_user_event(self: *spirv.Builder, result_type: spirv.Id) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 299,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn is_valid_event(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 300,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn set_user_event_status(self: *spirv.Builder, arg0: IdRef, arg1: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 301,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn capture_event_profiling_info(self: *spirv.Builder, arg0: IdRef, arg1: IdRef, arg2: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 302,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn get_default_queue(self: *spirv.Builder, result_type: spirv.Id) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try self.insns.append(self.allocator, .{
            .op = 303,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn build_n_d_range(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 304,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sparse_sample_implicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg2);
        try self.insns.append(self.allocator, .{
            .op = 305,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sparse_sample_explicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg2);
        try self.insns.append(self.allocator, .{
            .op = 306,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sparse_sample_dref_implicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg3);
        try self.insns.append(self.allocator, .{
            .op = 307,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sparse_sample_dref_explicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg3);
        try self.insns.append(self.allocator, .{
            .op = 308,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sparse_sample_proj_implicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg2);
        try self.insns.append(self.allocator, .{
            .op = 309,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sparse_sample_proj_explicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg2);
        try self.insns.append(self.allocator, .{
            .op = 310,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sparse_sample_proj_dref_implicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg3);
        try self.insns.append(self.allocator, .{
            .op = 311,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sparse_sample_proj_dref_explicit_lod(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg3);
        try self.insns.append(self.allocator, .{
            .op = 312,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sparse_fetch(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg2);
        try self.insns.append(self.allocator, .{
            .op = 313,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sparse_gather(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg3);
        try self.insns.append(self.allocator, .{
            .op = 314,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sparse_dref_gather(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef, arg3: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg3);
        try self.insns.append(self.allocator, .{
            .op = 315,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn image_sparse_texels_resident(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 316,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn no_line(self: *spirv.Builder) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try self.insns.append(self.allocator, .{
            .op = 317,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn atomic_flag_test_and_set(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try self.insns.append(self.allocator, .{
            .op = 318,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn atomic_flag_clear(self: *spirv.Builder, arg0: IdRef, arg1: IdScope, arg2: IdMemorySemantics) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdScope, arg1);
        try spirv.Builder.writeOperand(&operands, IdMemorySemantics, arg2);
        try self.insns.append(self.allocator, .{
            .op = 319,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn image_sparse_read(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: ?ImageOperands) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, ImageOperands, arg2);
        try self.insns.append(self.allocator, .{
            .op = 320,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn decorate_id(self: *spirv.Builder, arg0: IdRef, arg1: Decoration) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, Decoration, arg1);
        try self.insns.append(self.allocator, .{
            .op = 332,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn subgroup_ballot_k_h_r(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 4421,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn subgroup_first_invocation_k_h_r(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 4422,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn subgroup_all_k_h_r(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 4428,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn subgroup_any_k_h_r(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 4429,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn subgroup_all_equal_k_h_r(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 4430,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn subgroup_read_invocation_k_h_r(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 4432,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_i_add_non_uniform_a_m_d(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 5000,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_f_add_non_uniform_a_m_d(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 5001,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_f_min_non_uniform_a_m_d(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 5002,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_u_min_non_uniform_a_m_d(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 5003,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_s_min_non_uniform_a_m_d(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 5004,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_f_max_non_uniform_a_m_d(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 5005,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_u_max_non_uniform_a_m_d(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 5006,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn group_s_max_non_uniform_a_m_d(self: *spirv.Builder, result_type: spirv.Id, arg0: IdScope, arg1: GroupOperation, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdScope, arg0);
        try spirv.Builder.writeOperand(&operands, GroupOperation, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 5007,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn fragment_mask_fetch_a_m_d(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 5011,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn fragment_fetch_a_m_d(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 5012,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn subgroup_shuffle_i_n_t_e_l(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 5571,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn subgroup_shuffle_down_i_n_t_e_l(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 5572,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn subgroup_shuffle_up_i_n_t_e_l(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef, arg2: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 5573,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn subgroup_shuffle_xor_i_n_t_e_l(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 5574,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn subgroup_block_read_i_n_t_e_l(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try self.insns.append(self.allocator, .{
            .op = 5575,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn subgroup_block_write_i_n_t_e_l(self: *spirv.Builder, arg0: IdRef, arg1: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 5576,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn subgroup_image_block_read_i_n_t_e_l(self: *spirv.Builder, result_type: spirv.Id, arg0: IdRef, arg1: IdRef) !spirv.Id {
        const result = self.newId();
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, spirv.Id, result_type);
        try spirv.Builder.writeOperand(&operands, spirv.Id, result);
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try self.insns.append(self.allocator, .{
            .op = 5577,
            .operands = operands.toOwnedSlice(),
        });
        return result;
    }

    pub fn subgroup_image_block_write_i_n_t_e_l(self: *spirv.Builder, arg0: IdRef, arg1: IdRef, arg2: IdRef) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, IdRef, arg1);
        try spirv.Builder.writeOperand(&operands, IdRef, arg2);
        try self.insns.append(self.allocator, .{
            .op = 5578,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn decorate_string_g_o_o_g_l_e(self: *spirv.Builder, arg0: IdRef, arg1: Decoration) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, Decoration, arg1);
        try self.insns.append(self.allocator, .{
            .op = 5632,
            .operands = operands.toOwnedSlice(),
        });
    }

    pub fn member_decorate_string_g_o_o_g_l_e(self: *spirv.Builder, arg0: IdRef, arg1: LiteralInteger, arg2: Decoration) !void {
        var operands = std.ArrayList(spirv.Operand).init(self.allocator);
        errdefer operands.deinit();
        try spirv.Builder.writeOperand(&operands, IdRef, arg0);
        try spirv.Builder.writeOperand(&operands, LiteralInteger, arg1);
        try spirv.Builder.writeOperand(&operands, Decoration, arg2);
        try self.insns.append(self.allocator, .{
            .op = 5633,
            .operands = operands.toOwnedSlice(),
        });
    }
};

pub const ImageOperands = packed struct {
    bias: ?IdRef = null,
    lod: ?IdRef = null,
    grad: ?std.meta.Tuple(IdRef, IdRef) = null,
    const_offset: ?IdRef = null,
    offset: ?IdRef = null,
    const_offsets: ?IdRef = null,
    sample: ?IdRef = null,
    min_lod: ?IdRef = null,

    pub fn bitmask(self: ImageOperands) u32 {
        var bits: u32 = 0;
        if (self.bias != null) bits |= 0x1;
        if (self.lod != null) bits |= 0x2;
        if (self.grad != null) bits |= 0x4;
        if (self.const_offset != null) bits |= 0x8;
        if (self.offset != null) bits |= 0x10;
        if (self.const_offsets != null) bits |= 0x20;
        if (self.sample != null) bits |= 0x40;
        if (self.min_lod != null) bits |= 0x80;
        return bits;
    }
};

pub const FPFastMathMode = packed struct {
    not_na_n: bool = false,
    not_inf: bool = false,
    n_s_z: bool = false,
    allow_recip: bool = false,
    fast: bool = false,

    pub fn bitmask(self: FPFastMathMode) u32 {
        var bits: u32 = 0;
        if (self.not_na_n) bits |= 0x1;
        if (self.not_inf) bits |= 0x2;
        if (self.n_s_z) bits |= 0x4;
        if (self.allow_recip) bits |= 0x8;
        if (self.fast) bits |= 0x10;
        return bits;
    }
};

pub const SelectionControl = packed struct {
    flatten: bool = false,
    dont_flatten: bool = false,

    pub fn bitmask(self: SelectionControl) u32 {
        var bits: u32 = 0;
        if (self.flatten) bits |= 0x1;
        if (self.dont_flatten) bits |= 0x2;
        return bits;
    }
};

pub const LoopControl = packed struct {
    unroll: bool = false,
    dont_unroll: bool = false,

    pub fn bitmask(self: LoopControl) u32 {
        var bits: u32 = 0;
        if (self.unroll) bits |= 0x1;
        if (self.dont_unroll) bits |= 0x2;
        return bits;
    }
};

pub const FunctionControl = packed struct {
    @"inline": bool = false,
    dont_inline: bool = false,
    pure: bool = false,
    @"const": bool = false,

    pub fn bitmask(self: FunctionControl) u32 {
        var bits: u32 = 0;
        if (self.@"inline") bits |= 0x1;
        if (self.dont_inline) bits |= 0x2;
        if (self.pure) bits |= 0x4;
        if (self.@"const") bits |= 0x8;
        return bits;
    }
};

pub const MemorySemantics = packed struct {
    acquire: bool = false,
    release: bool = false,
    acquire_release: bool = false,
    sequentially_consistent: bool = false,
    uniform_memory: bool = false,
    subgroup_memory: bool = false,
    workgroup_memory: bool = false,
    cross_workgroup_memory: bool = false,
    atomic_counter_memory: bool = false,
    image_memory: bool = false,

    pub fn bitmask(self: MemorySemantics) u32 {
        var bits: u32 = 0;
        if (self.acquire) bits |= 0x2;
        if (self.release) bits |= 0x4;
        if (self.acquire_release) bits |= 0x8;
        if (self.sequentially_consistent) bits |= 0x10;
        if (self.uniform_memory) bits |= 0x40;
        if (self.subgroup_memory) bits |= 0x80;
        if (self.workgroup_memory) bits |= 0x100;
        if (self.cross_workgroup_memory) bits |= 0x200;
        if (self.atomic_counter_memory) bits |= 0x400;
        if (self.image_memory) bits |= 0x800;
        return bits;
    }
};

pub const MemoryAccess = packed struct {
    @"volatile": bool = false,
    aligned: ?LiteralInteger = null,
    nontemporal: bool = false,

    pub fn bitmask(self: MemoryAccess) u32 {
        var bits: u32 = 0;
        if (self.@"volatile") bits |= 0x1;
        if (self.aligned != null) bits |= 0x2;
        if (self.nontemporal) bits |= 0x4;
        return bits;
    }
};

pub const KernelProfilingInfo = packed struct {
    cmd_exec_time: bool = false,

    pub fn bitmask(self: KernelProfilingInfo) u32 {
        var bits: u32 = 0;
        if (self.cmd_exec_time) bits |= 0x1;
        return bits;
    }
};

pub const SourceLanguage = enum(u16) {
    unknown = 0,
    e_s_s_l = 1,
    g_l_s_l = 2,
    open_c_l__c = 3,
    open_c_l__c_p_p = 4,
    h_l_s_l = 5,
};

pub const ExecutionModel = enum(u16) {
    vertex = 0,
    tessellation_control = 1,
    tessellation_evaluation = 2,
    geometry = 3,
    fragment = 4,
    g_l_compute = 5,
    kernel = 6,
};

pub const AddressingModel = enum(u16) {
    logical = 0,
    physical32 = 1,
    physical64 = 2,
};

pub const MemoryModel = enum(u16) {
    simple = 0,
    g_l_s_l450 = 1,
    open_c_l = 2,
};

pub const ExecutionMode = union(ExecutionModeTag) {
    invocations: LiteralInteger,
    spacing_equal: void,
    spacing_fractional_even: void,
    spacing_fractional_odd: void,
    vertex_order_cw: void,
    vertex_order_ccw: void,
    pixel_center_integer: void,
    origin_upper_left: void,
    origin_lower_left: void,
    early_fragment_tests: void,
    point_mode: void,
    xfb: void,
    depth_replacing: void,
    depth_greater: void,
    depth_less: void,
    depth_unchanged: void,
    local_size: std.meta.Tuple(LiteralInteger, LiteralInteger, LiteralInteger),
    local_size_hint: std.meta.Tuple(LiteralInteger, LiteralInteger, LiteralInteger),
    input_points: void,
    input_lines: void,
    input_lines_adjacency: void,
    triangles: void,
    input_triangles_adjacency: void,
    quads: void,
    isolines: void,
    output_vertices: LiteralInteger,
    output_points: void,
    output_line_strip: void,
    output_triangle_strip: void,
    vec_type_hint: LiteralInteger,
    contraction_off: void,
    post_depth_coverage: void,
    stencil_ref_replacing_e_x_t: void,
};
pub const ExecutionModeTag = enum(u16) {
    invocations = 0,
    spacing_equal = 1,
    spacing_fractional_even = 2,
    spacing_fractional_odd = 3,
    vertex_order_cw = 4,
    vertex_order_ccw = 5,
    pixel_center_integer = 6,
    origin_upper_left = 7,
    origin_lower_left = 8,
    early_fragment_tests = 9,
    point_mode = 10,
    xfb = 11,
    depth_replacing = 12,
    depth_greater = 14,
    depth_less = 15,
    depth_unchanged = 16,
    local_size = 17,
    local_size_hint = 18,
    input_points = 19,
    input_lines = 20,
    input_lines_adjacency = 21,
    triangles = 22,
    input_triangles_adjacency = 23,
    quads = 24,
    isolines = 25,
    output_vertices = 26,
    output_points = 27,
    output_line_strip = 28,
    output_triangle_strip = 29,
    vec_type_hint = 30,
    contraction_off = 31,
    post_depth_coverage = 4446,
    stencil_ref_replacing_e_x_t = 5027,
};

pub const StorageClass = enum(u16) {
    uniform_constant = 0,
    input = 1,
    uniform = 2,
    output = 3,
    workgroup = 4,
    cross_workgroup = 5,
    private = 6,
    function = 7,
    generic = 8,
    push_constant = 9,
    atomic_counter = 10,
    image = 11,
    storage_buffer = 12,
};

pub const Dim = enum(u16) {
    @"1_d" = 0,
    @"2_d" = 1,
    @"3_d" = 2,
    cube = 3,
    rect = 4,
    buffer = 5,
    subpass_data = 6,
};

pub const SamplerAddressingMode = enum(u16) {
    none = 0,
    clamp_to_edge = 1,
    clamp = 2,
    repeat = 3,
    repeat_mirrored = 4,
};

pub const SamplerFilterMode = enum(u16) {
    nearest = 0,
    linear = 1,
};

pub const ImageFormat = enum(u16) {
    unknown = 0,
    rgba32f = 1,
    rgba16f = 2,
    r32f = 3,
    rgba8 = 4,
    rgba8_snorm = 5,
    rg32f = 6,
    rg16f = 7,
    r11f_g11f_b10f = 8,
    r16f = 9,
    rgba16 = 10,
    rgb10_a2 = 11,
    rg16 = 12,
    rg8 = 13,
    r16 = 14,
    r8 = 15,
    rgba16_snorm = 16,
    rg16_snorm = 17,
    rg8_snorm = 18,
    r16_snorm = 19,
    r8_snorm = 20,
    rgba32i = 21,
    rgba16i = 22,
    rgba8i = 23,
    r32i = 24,
    rg32i = 25,
    rg16i = 26,
    rg8i = 27,
    r16i = 28,
    r8i = 29,
    rgba32ui = 30,
    rgba16ui = 31,
    rgba8ui = 32,
    r32ui = 33,
    rgb10a2ui = 34,
    rg32ui = 35,
    rg16ui = 36,
    rg8ui = 37,
    r16ui = 38,
    r8ui = 39,
};

pub const ImageChannelOrder = enum(u16) {
    r = 0,
    a = 1,
    r_g = 2,
    r_a = 3,
    r_g_b = 4,
    r_g_b_a = 5,
    b_g_r_a = 6,
    a_r_g_b = 7,
    intensity = 8,
    luminance = 9,
    rx = 10,
    r_gx = 11,
    r_g_bx = 12,
    depth = 13,
    depth_stencil = 14,
    s_r_g_b = 15,
    s_r_g_bx = 16,
    s_r_g_b_a = 17,
    s_b_g_r_a = 18,
    a_b_g_r = 19,
};

pub const ImageChannelDataType = enum(u16) {
    snorm_int8 = 0,
    snorm_int16 = 1,
    unorm_int8 = 2,
    unorm_int16 = 3,
    unorm_short565 = 4,
    unorm_short555 = 5,
    unorm_int101010 = 6,
    signed_int8 = 7,
    signed_int16 = 8,
    signed_int32 = 9,
    unsigned_int8 = 10,
    unsigned_int16 = 11,
    unsigned_int32 = 12,
    half_float = 13,
    float = 14,
    unorm_int24 = 15,
    unorm_int101010_2 = 16,
};

pub const FPRoundingMode = enum(u16) {
    r_t_e = 0,
    r_t_z = 1,
    r_t_p = 2,
    r_t_n = 3,
};

pub const LinkageType = enum(u16) {
    @"export" = 0,
    import = 1,
};

pub const AccessQualifier = enum(u16) {
    read_only = 0,
    write_only = 1,
    read_write = 2,
};

pub const FunctionParameterAttribute = enum(u16) {
    zext = 0,
    sext = 1,
    by_val = 2,
    sret = 3,
    no_alias = 4,
    no_capture = 5,
    no_write = 6,
    no_read_write = 7,
};

pub const Decoration = union(DecorationTag) {
    relaxed_precision: void,
    spec_id: LiteralInteger,
    block: void,
    buffer_block: void,
    row_major: void,
    col_major: void,
    array_stride: LiteralInteger,
    matrix_stride: LiteralInteger,
    g_l_s_l_shared: void,
    g_l_s_l_packed: void,
    c_packed: void,
    built_in: BuiltIn,
    no_perspective: void,
    flat: void,
    patch: void,
    centroid: void,
    sample: void,
    invariant: void,
    restrict: void,
    aliased: void,
    @"volatile": void,
    constant: void,
    coherent: void,
    non_writable: void,
    non_readable: void,
    uniform: void,
    saturated_conversion: void,
    stream: LiteralInteger,
    location: LiteralInteger,
    component: LiteralInteger,
    index: LiteralInteger,
    binding: LiteralInteger,
    descriptor_set: LiteralInteger,
    offset: LiteralInteger,
    xfb_buffer: LiteralInteger,
    xfb_stride: LiteralInteger,
    func_param_attr: FunctionParameterAttribute,
    f_p_rounding_mode: FPRoundingMode,
    f_p_fast_math_mode: FPFastMathMode,
    linkage_attributes: std.meta.Tuple(LiteralString, LinkageType),
    no_contraction: void,
    input_attachment_index: LiteralInteger,
    alignment: LiteralInteger,
    explicit_interp_a_m_d: void,
    override_coverage_n_v: void,
    passthrough_n_v: void,
    viewport_relative_n_v: void,
    secondary_viewport_relative_n_v: LiteralInteger,
    hlsl_counter_buffer_g_o_o_g_l_e: IdRef,
    hlsl_semantic_g_o_o_g_l_e: LiteralString,
};
pub const DecorationTag = enum(u16) {
    relaxed_precision = 0,
    spec_id = 1,
    block = 2,
    buffer_block = 3,
    row_major = 4,
    col_major = 5,
    array_stride = 6,
    matrix_stride = 7,
    g_l_s_l_shared = 8,
    g_l_s_l_packed = 9,
    c_packed = 10,
    built_in = 11,
    no_perspective = 13,
    flat = 14,
    patch = 15,
    centroid = 16,
    sample = 17,
    invariant = 18,
    restrict = 19,
    aliased = 20,
    @"volatile" = 21,
    constant = 22,
    coherent = 23,
    non_writable = 24,
    non_readable = 25,
    uniform = 26,
    saturated_conversion = 28,
    stream = 29,
    location = 30,
    component = 31,
    index = 32,
    binding = 33,
    descriptor_set = 34,
    offset = 35,
    xfb_buffer = 36,
    xfb_stride = 37,
    func_param_attr = 38,
    f_p_rounding_mode = 39,
    f_p_fast_math_mode = 40,
    linkage_attributes = 41,
    no_contraction = 42,
    input_attachment_index = 43,
    alignment = 44,
    explicit_interp_a_m_d = 4999,
    override_coverage_n_v = 5248,
    passthrough_n_v = 5250,
    viewport_relative_n_v = 5252,
    secondary_viewport_relative_n_v = 5256,
    hlsl_counter_buffer_g_o_o_g_l_e = 5634,
    hlsl_semantic_g_o_o_g_l_e = 5635,
};

pub const BuiltIn = enum(u16) {
    position = 0,
    point_size = 1,
    clip_distance = 3,
    cull_distance = 4,
    vertex_id = 5,
    instance_id = 6,
    primitive_id = 7,
    invocation_id = 8,
    layer = 9,
    viewport_index = 10,
    tess_level_outer = 11,
    tess_level_inner = 12,
    tess_coord = 13,
    patch_vertices = 14,
    frag_coord = 15,
    point_coord = 16,
    front_facing = 17,
    sample_id = 18,
    sample_position = 19,
    sample_mask = 20,
    frag_depth = 22,
    helper_invocation = 23,
    num_workgroups = 24,
    workgroup_size = 25,
    workgroup_id = 26,
    local_invocation_id = 27,
    global_invocation_id = 28,
    local_invocation_index = 29,
    work_dim = 30,
    global_size = 31,
    enqueued_workgroup_size = 32,
    global_offset = 33,
    global_linear_id = 34,
    subgroup_size = 36,
    subgroup_max_size = 37,
    num_subgroups = 38,
    num_enqueued_subgroups = 39,
    subgroup_id = 40,
    subgroup_local_invocation_id = 41,
    vertex_index = 42,
    instance_index = 43,
    subgroup_eq_mask_k_h_r = 4416,
    subgroup_ge_mask_k_h_r = 4417,
    subgroup_gt_mask_k_h_r = 4418,
    subgroup_le_mask_k_h_r = 4419,
    subgroup_lt_mask_k_h_r = 4420,
    base_vertex = 4424,
    base_instance = 4425,
    draw_index = 4426,
    device_index = 4438,
    view_index = 4440,
    bary_coord_no_persp_a_m_d = 4992,
    bary_coord_no_persp_centroid_a_m_d = 4993,
    bary_coord_no_persp_sample_a_m_d = 4994,
    bary_coord_smooth_a_m_d = 4995,
    bary_coord_smooth_centroid_a_m_d = 4996,
    bary_coord_smooth_sample_a_m_d = 4997,
    bary_coord_pull_model_a_m_d = 4998,
    frag_stencil_ref_e_x_t = 5014,
    viewport_mask_n_v = 5253,
    secondary_position_n_v = 5257,
    secondary_viewport_mask_n_v = 5258,
    position_per_view_n_v = 5261,
    viewport_mask_per_view_n_v = 5262,
};

pub const Scope = enum(u16) {
    cross_device = 0,
    device = 1,
    workgroup = 2,
    subgroup = 3,
    invocation = 4,
};

pub const GroupOperation = enum(u16) {
    reduce = 0,
    inclusive_scan = 1,
    exclusive_scan = 2,
};

pub const KernelEnqueueFlags = enum(u16) {
    no_wait = 0,
    wait_kernel = 1,
    wait_work_group = 2,
};

pub const Capability = enum(u16) {
    matrix = 0,
    shader = 1,
    geometry = 2,
    tessellation = 3,
    addresses = 4,
    linkage = 5,
    kernel = 6,
    vector16 = 7,
    float16_buffer = 8,
    float16 = 9,
    float64 = 10,
    int64 = 11,
    int64_atomics = 12,
    image_basic = 13,
    image_read_write = 14,
    image_mipmap = 15,
    pipes = 17,
    groups = 18,
    device_enqueue = 19,
    literal_sampler = 20,
    atomic_storage = 21,
    int16 = 22,
    tessellation_point_size = 23,
    geometry_point_size = 24,
    image_gather_extended = 25,
    storage_image_multisample = 27,
    uniform_buffer_array_dynamic_indexing = 28,
    sampled_image_array_dynamic_indexing = 29,
    storage_buffer_array_dynamic_indexing = 30,
    storage_image_array_dynamic_indexing = 31,
    clip_distance = 32,
    cull_distance = 33,
    image_cube_array = 34,
    sample_rate_shading = 35,
    image_rect = 36,
    sampled_rect = 37,
    generic_pointer = 38,
    int8 = 39,
    input_attachment = 40,
    sparse_residency = 41,
    min_lod = 42,
    sampled1_d = 43,
    image1_d = 44,
    sampled_cube_array = 45,
    sampled_buffer = 46,
    image_buffer = 47,
    image_m_s_array = 48,
    storage_image_extended_formats = 49,
    image_query = 50,
    derivative_control = 51,
    interpolation_function = 52,
    transform_feedback = 53,
    geometry_streams = 54,
    storage_image_read_without_format = 55,
    storage_image_write_without_format = 56,
    multi_viewport = 57,
    subgroup_ballot_k_h_r = 4423,
    draw_parameters = 4427,
    subgroup_vote_k_h_r = 4431,
    storage_buffer16_bit_access = 4433,
    uniform_and_storage_buffer16_bit_access = 4434,
    storage_push_constant16 = 4435,
    storage_input_output16 = 4436,
    device_group = 4437,
    multi_view = 4439,
    variable_pointers_storage_buffer = 4441,
    variable_pointers = 4442,
    atomic_storage_ops = 4445,
    sample_mask_post_depth_coverage = 4447,
    image_gather_bias_lod_a_m_d = 5009,
    fragment_mask_a_m_d = 5010,
    stencil_export_e_x_t = 5013,
    image_read_write_lod_a_m_d = 5015,
    sample_mask_override_coverage_n_v = 5249,
    geometry_shader_passthrough_n_v = 5251,
    shader_viewport_index_layer_e_x_t = 5254,
    shader_viewport_mask_n_v = 5255,
    shader_stereo_view_n_v = 5259,
    per_view_attributes_n_v = 5260,
    subgroup_shuffle_i_n_t_e_l = 5568,
    subgroup_buffer_block_i_o_i_n_t_e_l = 5569,
    subgroup_image_block_i_o_i_n_t_e_l = 5570,
};

/// Reference to an <id> representing the result's type of the enclosing instruction
pub const IdResultType = spirv.Id;

/// Definition of an <id> representing the result of the enclosing instruction
pub const IdResult = spirv.Id;

/// Reference to an <id> representing a 32-bit integer that is a mask from the MemorySemantics operand kind
pub const IdMemorySemantics = spirv.Id;

/// Reference to an <id> representing a 32-bit integer that is a mask from the Scope operand kind
pub const IdScope = spirv.Id;

/// Reference to an <id>
pub const IdRef = spirv.Id;

/// An integer consuming one or more words
pub const LiteralInteger = u64;

/// A null-terminated stream of characters consuming an integral number of words
pub const LiteralString = []const u8;

/// A literal number whose size and format are determined by a previous operand in the enclosing instruction
pub const LiteralContextDependentNumber = @compileError("TODO");

/// A 32-bit unsigned integer indicating which instruction to use and determining the layout of following operands (for OpExtInst)
pub const LiteralExtInstInteger = @compileError("TODO");

/// An opcode indicating the operation to be performed and determining the layout of following operands (for OpSpecConstantOp)
pub const LiteralSpecConstantOpInteger = @compileError("TODO");

pub const PairLiteralIntegerIdRef = std.meta.Tuple(&.{ LiteralInteger, IdRef });

pub const PairIdRefLiteralInteger = std.meta.Tuple(&.{ IdRef, LiteralInteger });

pub const PairIdRefIdRef = std.meta.Tuple(&.{ IdRef, IdRef });
