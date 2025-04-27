const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    const wasm_number_of_pages = 2148;

    const wasm_target = b.resolveTargetQuery(.{
        .cpu_arch = .wasm32,
        .os_tag = .wasi,
    });

    const wasm_exe = b.addExecutable(.{
        .name = "anura-front",
        .root_source_file = b.path("src/front.zig"),
        .target = wasm_target,
        .optimize = .ReleaseSmall,
    });

    // <https://github.com/ziglang/zig/issues/8633>
    // wasm_exe.global_base = 6560;
    // wasm_exe.entry = .disabled;
    wasm_exe.rdynamic = true;
    // wasm_exe.import_memory = true;
    // wasm_exe.stack_size = std.wasm.page_size;

    wasm_exe.initial_memory = std.wasm.page_size * wasm_number_of_pages;
    wasm_exe.max_memory = std.wasm.page_size * wasm_number_of_pages;

    b.installArtifact(wasm_exe);

    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/test.zig"),
        .target = target,
        .optimize = optimize,
    });

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);
}
