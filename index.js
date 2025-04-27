import { WASI, File, OpenFile, ConsoleStdout, PreopenDirectory } from 'https://cdn.jsdelivr.net/npm/@bjorn3/browser_wasi_shim@0.2.19/+esm';

async function init() {
    console.log('todo init');
    
    let fileDescriptors = [
        new OpenFile(new File([])), // stdin
        ConsoleStdout.lineBuffered(console.log),
        ConsoleStdout.lineBuffered(console.log),
        new PreopenDirectory(".", {}),
    ];
    
    let wasi = new WASI([], [], fileDescriptors);

    var importObject = {
        wasi_snapshot_preview1: wasi.wasiImport,
        for_zig: {
        }
    };

    const context = await WebAssembly.instantiateStreaming(fetch("zig-out/bin/anura-front.wasm"), importObject);
    wasi.start(context.instance);
    
    const {
        croak,
    } = context.instance.exports;

    console.log(croak());
}

init();
