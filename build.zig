const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const cycle_dep = b.dependency("cycle", .{});
    const cycleLink = @import("cycle").link;

    const exe = b.addExecutable(.{
        .name = "kanban",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe.addModule("cycle", cycle_dep.module("cycle"));
    cycleLink(cycle_dep.builder, exe);

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const main_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    main_tests.addModule("cycle", cycle_dep.module("cycle"));

    const run_main_tests = b.addRunArtifact(main_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_main_tests.step);
}
