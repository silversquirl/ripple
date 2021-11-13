const std = @import("std");

pub fn main() !u8 {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = &arena.allocator;

    const err = std.io.getStdErr().writer();

    var args = std.process.args();
    std.debug.assert(args.skip());
    const cmd_name = try args.next(allocator) orelse {
        try usage(err);
        return 1;
    };

    const cmd = commands.get(cmd_name) orelse {
        try usage(err);
        return 1;
    };

    return try cmd(&args);
}

fn usage(out: anytype) !void {
    try out.writeAll(
        \\Usage: ripple COMMAND [ARGS...]
        \\
        \\Commands:
        \\
        \\  compile     Compile a Ripple source file to SPIR-V
        \\  help        Print this help message
        \\
        \\
    );
}

const commands = std.ComptimeStringMap(fn (*std.process.ArgIterator) anyerror!u8, .{
    .{ "compile", compile },
    .{ "help", help },
});

fn help(_: *std.process.ArgIterator) !u8 {
    const out = std.io.getStdOut().writer();
    try usage(out);
    return 0;
}

fn compile(args: *std.process.ArgIterator) !u8 {
    _ = args;
    @panic("TODO");
}
