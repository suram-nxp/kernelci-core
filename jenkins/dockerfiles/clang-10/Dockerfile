FROM kernelci/build-base

RUN apt-get update && apt-get install --no-install-recommends -y \
    software-properties-common \
    gnupg2

RUN wget -q -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt-add-repository 'deb http://apt.llvm.org/buster/ llvm-toolchain-buster-10 main'

RUN apt-get update && apt-get install --no-install-recommends -y \
    binutils-aarch64-linux-gnu \
    binutils-arm-linux-gnueabihf \
    binutils \
    clang-10 lld-10 llvm-10

ENV PATH=/usr/lib/llvm-10/bin:${PATH}

RUN apt-get autoremove -y gcc
