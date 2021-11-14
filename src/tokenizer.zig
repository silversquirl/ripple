const std = @import("std");

const Token = struct {
    tag: Tag,
    loc: Loc,

    pub const Loc = struct {
        start: usize,
        end: usize,
    };

    pub const Tag = union(enum) {
        kw_type,
        kw_struct,
        kw_ref,
        kw_flat,
        kw_view,
        kw_entry,
        kw_fn,
        kw_if,
        kw_else,
        kw_while,
        kw_for,
        kw_return,
        kw_break,
        kw_continue,
        kw_and,
        kw_or,
        kw_const,
        kw_var,
        kw_undefined,

        dot,
        comma,
        pipe,
        colon,
        semicolon,
        lbrace,
        rbrace,
        lbracket,
        rbracket,
        lparen,
        rparen,

        equals,
        plus,
        minus,
        mult,
        div,
        mod,
        lshift,
        rshift,
        plus_eq,
        minus_eq,
        mult_eq,
        div_eq,
        mod_eq,
        lshift_eq,
        rshift_eq,
        @"and",
        or_eq, // we don't have an 'or', it's called 'pipe' because captures
        and_eq,

        cmp_eq,
        cmp_leq,
        cmp_geq,
        cmp_lt,
        cmp_gt,

        type_uint: u64,
        type_sint: u64,
        type_float: u64,

        int_lit: i65,
        float_lit: f64,
        dimension: [2]u64,

        identifier: []const u8,
        builtin: []const u8,
    };
};

pub fn Tokenizer(comptime Reader: type) type {
    return struct {
        ps: std.io.PeekStream(.{ .Static = max_lookahead }, Reader),
        pos: usize = 0,
        arena: std.heap.ArenaAllocator,

        const Self = @This();
        const max_lookahead = 64;

        pub fn init(allocator: *std.mem.Allocator, r: Reader) Self {
            return .{
                .ps = std.io.peekStream(max_lookahead, r),
                .arena = std.heap.ArenaAllocator.init(allocator),
            };
        }

        pub fn deinit(self: *Self) void {
            self.arena.deinit();
        }

        pub fn next(self: *Self) !Token {
            // consume trailing whitespace
            while (self.ps.reader().readByte()) |c| {
                if (!std.ascii.isSpace(c)) {
                    self.ps.putBackByte(c) catch unreachable;
                    break;
                }
                self.pos += 1;
            } else |err| return err;

            const keywords = [_]std.meta.Tuple(&.{ []const u8, Token.Tag }){
                .{ "type", .kw_type },
                .{ "struct", .kw_struct },
                .{ "ref", .kw_ref },
                .{ "flat", .kw_flat },
                .{ "view", .kw_view },
                .{ "entry", .kw_entry },
                .{ "fn", .kw_fn },
                .{ "if", .kw_if },
                .{ "else", .kw_else },
                .{ "while", .kw_while },
                .{ "for", .kw_for },
                .{ "return", .kw_return },
                .{ "break", .kw_break },
                .{ "continue", .kw_continue },
                .{ "and", .kw_and },
                .{ "or", .kw_or },
                .{ "const", .kw_const },
                .{ "undefined", .kw_undefined },
                .{ "var", .kw_var },
            };

            inline for (keywords) |kw| {
                if (try self.matchKeyword(kw[0])) |loc| {
                    return Token{ .tag = kw[1], .loc = loc };
                }
            }

            if (try self.parseLiteral()) |tok| return tok;
            if (try self.parseBuiltin()) |tok| return tok;
            if (try self.parseIdent()) |tok| return tok;

            const lits = [_]std.meta.Tuple(&.{ []const u8, Token.Tag }){
                .{ ".", .dot },
                .{ ",", .comma },
                .{ "|", .pipe },
                .{ ":", .colon },
                .{ ";", .semicolon },
                .{ "{", .lbrace },
                .{ "}", .rbrace },
                .{ "[", .lbracket },
                .{ "]", .rbracket },
                .{ "(", .lparen },
                .{ ")", .rparen },

                .{ "+=", .plus_eq },
                .{ "-=", .minus_eq },
                .{ "*=", .mult_eq },
                .{ "/=", .div_eq },
                .{ "%=", .mod_eq },
                .{ "<<=", .lshift_eq },
                .{ ">>=", .rshift_eq },
                .{ "|=", .or_eq },
                .{ "&=", .and_eq },

                .{ "+", .plus },
                .{ "-", .minus },
                .{ "*", .mult },
                .{ "/", .div },
                .{ "%", .mod },
                .{ "<<", .lshift },
                .{ ">>", .rshift },
                .{ "&", .@"and" },

                .{ "==", .cmp_eq },
                .{ ">=", .cmp_geq },
                .{ "<=", .cmp_leq },
                .{ ">", .cmp_gt },
                .{ "<", .cmp_lt },

                .{ "=", .equals },
            };

            inline for (lits) |l| {
                if (try self.match(l[0])) |loc| {
                    return Token{ .tag = l[1], .loc = loc };
                }
            }

            return error.BadToken;
        }

        fn parseLiteral(self: *Self) !?Token {
            const str = try self.getAlphaNum("+-0123456789", true);
            defer self.arena.allocator.free(str);

            if (str.len == 0) return null;

            const tag: Token.Tag = blk: {
                if (std.mem.indexOfScalar(u8, str, 'x')) |idx| {
                    if (std.fmt.parseUnsigned(u64, str[0..idx], 10)) |rows| {
                        if (std.fmt.parseUnsigned(u64, str[idx + 1 ..], 10)) |cols| {
                            break :blk .{ .dimension = .{ rows, cols } };
                        } else |err| if (err == error.Overflow) return error.Overflow;
                    } else |err| if (err == error.Overflow) return error.Overflow;
                }

                if (std.fmt.parseInt(i65, str, 0)) |i| {
                    break :blk .{ .int_lit = i };
                } else |err| switch (err) {
                    error.Overflow => return error.Overflow,
                    error.InvalidCharacter => {},
                }

                if (std.fmt.parseFloat(f64, str)) |f| {
                    break :blk .{ .float_lit = f };
                } else |_| {}

                return error.BadLiteral;
            };

            const start = self.pos;
            self.pos += str.len;
            const loc = Token.Loc{ .start = start, .end = self.pos };

            return Token{ .loc = loc, .tag = tag };
        }

        fn parseBuiltin(self: *Self) !?Token {
            const str = try self.getAlphaNum("@", false);

            if (str.len == 0) return null;

            const start = self.pos;
            self.pos += str.len;
            const loc = Token.Loc{ .start = start, .end = self.pos };

            return Token{ .loc = loc, .tag = .{ .builtin = str } };
        }

        // This will also consume literals, so it's important it's run
        // *after* parseLiteral
        fn parseIdent(self: *Self) !?Token {
            const str = try self.getAlphaNum(null, false);
            if (str.len == 0) return null;

            const tag: Token.Tag = blk: {
                if (str[0] == 'u' or str[0] == 's' or str[0] == 'f') {
                    if (std.fmt.parseUnsigned(u64, str[1..], 10)) |x| {
                        switch (str[0]) {
                            'u' => break :blk .{ .type_uint = x },
                            's' => break :blk .{ .type_sint = x },
                            'f' => break :blk .{ .type_float = x },
                            else => unreachable,
                        }
                    } else |_| {}
                }

                break :blk .{ .identifier = str };
            };

            const start = self.pos;
            self.pos += str.len;
            const loc = Token.Loc{ .start = start, .end = self.pos };

            return Token{ .loc = loc, .tag = tag };
        }

        fn getAlphaNum(self: *Self, first_chars: ?[]const u8, allow_dot: bool) ![]u8 {
            var str = std.ArrayList(u8).init(&self.arena.allocator);
            defer str.deinit();

            var i: usize = 0;
            while (self.ps.reader().readByte()) |c| : (i += 1) {
                if (i == 0) {
                    if (first_chars) |cs| {
                        if (std.mem.indexOfScalar(u8, cs, c) == null) {
                            self.ps.putBackByte(c) catch unreachable;
                            break;
                        } else {
                            try str.append(c);
                            continue;
                        }
                    }
                }

                if ((c < 'a' or c > 'z') and
                    (c < 'A' or c > 'Z') and
                    (c < '0' or c > '9') and
                    c != '_' and
                    (c != '.' or !allow_dot))
                {
                    self.ps.putBackByte(c) catch unreachable;
                    break;
                }

                try str.append(c);
            } else |err| switch (err) {
                error.EndOfStream => {},
                else => |e| return e,
            }

            return str.toOwnedSlice();
        }

        fn match(self: *Self, comptime str: []const u8) !?Token.Loc {
            if (str.len > max_lookahead) @compileError("Insufficient lookahead");

            for (str) |c, i| {
                const c1 = self.ps.reader().readByte() catch |err| switch (err) {
                    error.EndOfStream => {
                        self.ps.putBack(str[0..i]) catch unreachable;
                        return null;
                    },
                    else => |e| return e,
                };

                if (c1 != c) {
                    self.ps.putBackByte(c1) catch unreachable;
                    self.ps.putBack(str[0..i]) catch unreachable;
                    return null;
                }
            }

            const start = self.pos;
            self.pos += str.len;

            return Token.Loc{ .start = start, .end = self.pos };
        }

        fn matchKeyword(self: *Self, comptime str: []const u8) !?Token.Loc {
            if (str.len + 1 > max_lookahead) @compileError("Insufficient lookahead");

            const res = (try self.match(str)) orelse return null;

            const c = self.ps.reader().readByte() catch |err| switch (err) {
                error.EndOfStream => return res,
                else => |e| return e,
            };

            if ((c >= 'a' and c <= 'z') or
                (c >= 'A' and c <= 'Z') or
                (c >= '0' and c <= '9') or
                c == '_')
            {
                self.ps.putBack(str) catch unreachable;
                return null;
            }

            return res;
        }
    };
}

pub fn tokenizer(allocator: *std.mem.Allocator, r: anytype) Tokenizer(@TypeOf(r)) {
    return Tokenizer(@TypeOf(r)).init(allocator, r);
}

fn tokenEql(a: Token, b: Token) bool {
    if (a.loc.start != b.loc.start) return false;
    if (a.loc.end != b.loc.end) return false;

    if (@as(std.meta.Tag(Token.Tag), a.tag) != @as(std.meta.Tag(Token.Tag), b.tag)) return false;

    switch (a.tag) {
        .type_uint, .type_sint, .type_float => |x| switch (b.tag) {
            .type_uint, .type_sint, .type_float => |y| return x == y,
            else => unreachable,
        },

        .int_lit => |x| return x == b.tag.int_lit,
        .float_lit => |x| return x == b.tag.float_lit,
        .dimension => |x| return std.meta.eql(x, b.tag.dimension),

        .identifier => |x| return std.mem.eql(u8, x, b.tag.identifier),
        .builtin => |x| return std.mem.eql(u8, x, b.tag.builtin),

        else => return true,
    }
}

test {
    var r = std.io.fixedBufferStream(
        \\ fn foo(x: u8) [3x4]u8 {
        \\      const y = @myBuiltin(x, 4.5);
        \\
        \\      if (y) |y1| return y1;
        \\
        \\      return .{
        \\          1, 2, 3, 4,
        \\          2, 3, 4, 5,
        \\          3, 4, 5, 6,
        \\      };
        \\ }
    ).reader();
    var tok = tokenizer(std.testing.allocator, r);
    defer tok.deinit();

    const expected = [_]Token{
        .{ .tag = .kw_fn, .loc = .{ .start = 1, .end = 3 } },
        .{ .tag = .{ .identifier = "foo" }, .loc = .{ .start = 3, .end = 6 } },
        .{ .tag = .lparen, .loc = .{ .start = 6, .end = 7 } },
        .{ .tag = .{ .identifier = "x" }, .loc = .{ .start = 7, .end = 8 } },
        .{ .tag = .colon, .loc = .{ .start = 8, .end = 9 } },
        .{ .tag = .{ .type_uint = 8 }, .loc = .{ .start = 10, .end = 12 } },
        .{ .tag = .rparen, .loc = .{ .start = 12, .end = 13 } },
        .{ .tag = .lbracket, .loc = .{ .start = 14, .end = 15 } },
        .{ .tag = .{ .dimension = .{ 3, 4 } }, .loc = .{ .start = 15, .end = 18 } },
        .{ .tag = .rbracket, .loc = .{ .start = 18, .end = 19 } },
        .{ .tag = .{ .type_uint = 8 }, .loc = .{ .start = 19, .end = 21 } },
        .{ .tag = .lbrace, .loc = .{ .start = 22, .end = 23 } },
        .{ .tag = .kw_const, .loc = .{ .start = 30, .end = 35 } },
        .{ .tag = .{ .identifier = "y" }, .loc = .{ .start = 35, .end = 36 } },
        .{ .tag = .equals, .loc = .{ .start = 37, .end = 38 } },
        .{ .tag = .{ .builtin = "@myBuiltin" }, .loc = .{ .start = 39, .end = 49 } },
        .{ .tag = .lparen, .loc = .{ .start = 49, .end = 50 } },
        .{ .tag = .{ .identifier = "x" }, .loc = .{ .start = 50, .end = 51 } },
        .{ .tag = .comma, .loc = .{ .start = 51, .end = 52 } },
        .{ .tag = .{ .float_lit = 4.5e+00 }, .loc = .{ .start = 53, .end = 56 } },
        .{ .tag = .rparen, .loc = .{ .start = 56, .end = 57 } },
        .{ .tag = .semicolon, .loc = .{ .start = 57, .end = 58 } },
        .{ .tag = .kw_if, .loc = .{ .start = 66, .end = 68 } },
        .{ .tag = .lparen, .loc = .{ .start = 68, .end = 69 } },
        .{ .tag = .{ .identifier = "y" }, .loc = .{ .start = 69, .end = 70 } },
        .{ .tag = .rparen, .loc = .{ .start = 70, .end = 71 } },
        .{ .tag = .pipe, .loc = .{ .start = 72, .end = 73 } },
        .{ .tag = .{ .identifier = "y1" }, .loc = .{ .start = 73, .end = 75 } },
        .{ .tag = .pipe, .loc = .{ .start = 75, .end = 76 } },
        .{ .tag = .kw_return, .loc = .{ .start = 77, .end = 83 } },
        .{ .tag = .{ .identifier = "y1" }, .loc = .{ .start = 83, .end = 85 } },
        .{ .tag = .semicolon, .loc = .{ .start = 85, .end = 86 } },
        .{ .tag = .kw_return, .loc = .{ .start = 94, .end = 100 } },
        .{ .tag = .dot, .loc = .{ .start = 100, .end = 101 } },
        .{ .tag = .lbrace, .loc = .{ .start = 101, .end = 102 } },
        .{ .tag = .{ .int_lit = 1 }, .loc = .{ .start = 113, .end = 114 } },
        .{ .tag = .comma, .loc = .{ .start = 114, .end = 115 } },
        .{ .tag = .{ .int_lit = 2 }, .loc = .{ .start = 116, .end = 117 } },
        .{ .tag = .comma, .loc = .{ .start = 117, .end = 118 } },
        .{ .tag = .{ .int_lit = 3 }, .loc = .{ .start = 119, .end = 120 } },
        .{ .tag = .comma, .loc = .{ .start = 120, .end = 121 } },
        .{ .tag = .{ .int_lit = 4 }, .loc = .{ .start = 122, .end = 123 } },
        .{ .tag = .comma, .loc = .{ .start = 123, .end = 124 } },
        .{ .tag = .{ .int_lit = 2 }, .loc = .{ .start = 135, .end = 136 } },
        .{ .tag = .comma, .loc = .{ .start = 136, .end = 137 } },
        .{ .tag = .{ .int_lit = 3 }, .loc = .{ .start = 138, .end = 139 } },
        .{ .tag = .comma, .loc = .{ .start = 139, .end = 140 } },
        .{ .tag = .{ .int_lit = 4 }, .loc = .{ .start = 141, .end = 142 } },
        .{ .tag = .comma, .loc = .{ .start = 142, .end = 143 } },
        .{ .tag = .{ .int_lit = 5 }, .loc = .{ .start = 144, .end = 145 } },
        .{ .tag = .comma, .loc = .{ .start = 145, .end = 146 } },
        .{ .tag = .{ .int_lit = 3 }, .loc = .{ .start = 157, .end = 158 } },
        .{ .tag = .comma, .loc = .{ .start = 158, .end = 159 } },
        .{ .tag = .{ .int_lit = 4 }, .loc = .{ .start = 160, .end = 161 } },
        .{ .tag = .comma, .loc = .{ .start = 161, .end = 162 } },
        .{ .tag = .{ .int_lit = 5 }, .loc = .{ .start = 163, .end = 164 } },
        .{ .tag = .comma, .loc = .{ .start = 164, .end = 165 } },
        .{ .tag = .{ .int_lit = 6 }, .loc = .{ .start = 166, .end = 167 } },
        .{ .tag = .comma, .loc = .{ .start = 167, .end = 168 } },
        .{ .tag = .rbrace, .loc = .{ .start = 175, .end = 176 } },
        .{ .tag = .semicolon, .loc = .{ .start = 176, .end = 177 } },
        .{ .tag = .rbrace, .loc = .{ .start = 179, .end = 180 } },
    };

    var i: usize = 0;
    while (tok.next()) |t| : (i += 1) {
        try std.testing.expect(i < expected.len);
        try std.testing.expect(tokenEql(t, expected[i]));
    } else |err| switch (err) {
        error.EndOfStream => {},
        else => |e| return e,
    }

    try std.testing.expectEqual(i, expected.len);
}
