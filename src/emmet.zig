const std = @import("std");
const testing = std.testing;

fn em(comptime source: []const u8) void {
    _ = source;
}

test {
    try testing.expect(true);
}

