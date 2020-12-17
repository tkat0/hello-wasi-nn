# hello-wasi-nn

download test data.

```bash
FIXTURE=https://github.com/intel/openvino-rs/raw/main/crates/openvino/tests/fixtures/alexnet
TMP_DIR=./tmp
mkdir -p $TMP_DIR

wget --no-clobber --directory-prefix=$TMP_DIR $FIXTURE/alexnet.bin
wget --no-clobber --directory-prefix=$TMP_DIR $FIXTURE/alexnet.xml
wget --no-clobber --directory-prefix=$TMP_DIR $FIXTURE/tensor-1x3x227x227-f32.bgr
```

build and run docker image to execute wasmtime with wasi-nn enabled.

```bash
$ docker-compose run dev
```

build test application.

```bash
root@0481d31f4627:/work/wasmtime/crates/wasi-nn/examples/classification-example# cargo build --release --target=wasm32-wasi
root@0481d31f4627:/work/wasmtime/crates/wasi-nn/examples/classification-example# cp /work/wasmtime/target/wasm32-wasi/release/wasi-nn-example.wasm /work/tmp
```

run test application

```bash
root@0481d31f4627:/work# wasmtime --mapdir fixture::./tmp ./tmp/wasi-nn-example.wasm 
Read graph XML, first 50 characters: <?xml version="1.0" ?>
<net name="AlexNet" version
Read graph weights, size in bytes: 243860936
Loaded graph into wasi-nn with ID: 0
Created wasi-nn execution context with ID: 0
Read input tensor, size in bytes: 618348
Executed graph inference
Found results, sorted top 5: [InferenceResult(963, 0.5316792), InferenceResult(923, 0.10493353), InferenceResult(926, 0.101960495), InferenceResult(909, 0.06172997), InferenceResult(762, 0.055457264)]
```