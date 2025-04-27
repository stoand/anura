const std = @import("std");

pub fn main() !void {}

fn em(comptime emmet: []const u8) void {
    _ = emmet;
    return undefined;
}

fn print() void {
    std.debug.print("asdf\n");
}

export fn render() u32 {

    _ = em(".first[onClick print]+.second+(li)");
    
    // const dom = el("div", &.{}, &.{em(".asdf>span.second#id0")});
    // _ = dom;

    return 0;
}

export fn croak() u32 {
    return 1234;
}
