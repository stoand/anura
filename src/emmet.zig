const std = @import("std");
const testing = std.testing;

fn em(comptime source: []const u8) type {
    _ = source;

    return @Type(.{
        .@"struct" = .{
            .layout = .auto,
            .fields = &.{
                .{
                    .alignment = 0,
                    .default_value_ptr = null,
                    .is_comptime = false,
                    .name = "bindthis",
                    .type = []const u8,
                },
            },
            .decls = &.{},
            .is_tuple = false,
        },
    });
}

test {
    const ty = em("div.class0{@bindthis}");

    const val: ty = .{ .bindthis = "asdf" };
    _ = val;
    
    try testing.expect(true);
}
