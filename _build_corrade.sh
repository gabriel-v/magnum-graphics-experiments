#!/bin/bash -ex

cd "$(dirname ${BASH_SOURCE[0]})"
cd lib/corrade
(
    mkdir build && cd build
    cmake .. \
	# -DCMAKE_BUILD_TYPE=Release

    cmake --build . -j8
    cmake --build . --target install
)

(
    mkdir emscripten-build && cd emscripten-build
    cmake .. \
	-DCMAKE_TOOLCHAIN_FILE="/app/lib/toolchains/generic/Emscripten-wasm.cmake" \
	-DCMAKE_INSTALL_PREFIX="/usr/lib/emscripten/system" \
	# -DCMAKE_BUILD_TYPE=Release

    cmake --build . -j8
    cmake --build . --target install
)
