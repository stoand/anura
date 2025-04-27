const std = @import("std");
const testing = std.testing;

const emmet = @import("./emmet.zig");

test "refAllDecls" {
    testing.refAllDecls(emmet);
}
