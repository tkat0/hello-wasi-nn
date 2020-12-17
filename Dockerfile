FROM rust:1.48.0

RUN rustup target add wasm32-wasi

ARG VERSION="2020.4.287"

# https://docs.openvinotoolkit.org/latest/openvino_docs_install_guides_installing_openvino_apt.html
# https://github.com/bytecodealliance/wasmtime/tree/main/.github/actions/install-openvino
RUN curl -sSL https://apt.repos.intel.com/openvino/2020/GPG-PUB-KEY-INTEL-OPENVINO-2020 > GPG-PUB-KEY-INTEL-OPENVINO-2020 \
    && apt-key add GPG-PUB-KEY-INTEL-OPENVINO-2020 \
    && echo "deb https://apt.repos.intel.com/openvino/2020 all main" | tee /etc/apt/sources.list.d/intel-openvino-2020.list \
    && apt update \
    && apt install -y intel-openvino-runtime-ubuntu18-$VERSION

RUN apt install -y clang

ENV OPENVINO_INSTALL_DIR=/opt/intel/openvino

COPY ./wasmtime /opt/wasmtime

WORKDIR /opt/wasmtime
RUN cargo install --features wasi-nn --path .

RUN echo "source /opt/intel/openvino/bin/setupvars.sh" >> /root/.bashrc

WORKDIR /work