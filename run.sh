

FIXTURE=https://github.com/intel/openvino-rs/raw/main/crates/openvino/tests/fixtures/alexnet
TMP_DIR=./tmp
mkdir -p $TMP_DIR

wget --no-clobber --directory-prefix=$TMP_DIR $FIXTURE/alexnet.bin
wget --no-clobber --directory-prefix=$TMP_DIR $FIXTURE/alexnet.xml
wget --no-clobber --directory-prefix=$TMP_DIR $FIXTURE/tensor-1x3x227x227-f32.bgr

# pushd $WASMTIME_DIR/crates/wasi-nn/examples/classification-example
# cargo build --release --target=wasm32-wasi
# cp target/wasm32-wasi/release/wasi-nn-example.wasm $TMP_DIR
# popd

