const std = @import("std");
const cy = @import("cycle");
const scm = @import("scm.zig");

pub fn main() !void {
    const allocator = std.heap.c_allocator;

    const Index = cy.obj.Index(.{scm.data});
    var store = cy.obj.Store(Index).init(allocator);
    defer store.deinit();

    var chan = try cy.init(allocator, .{
        .index = Index.infos,
        .render = Index.ids,
    });

    while (try chan.read()) |msg| {
        switch (msg.tag()) {}
    }
}
