#!/bin/bash -ex

cd "$(dirname ${BASH_SOURCE[0]})"
cd lib/magnum
(
mkdir build && cd build
	# -DMAGNUM_WITH_SDL2APPLICATION=ON \
    cmake .. \
	-DMAGNUM_WITH_PYTHON=ON \
	-DCMAKE_TOOLCHAIN_FILE="/app/lib/toolchains/generic/Emscripten-wasm.cmake" \
	-DCMAKE_PREFIX_PATH="/usr/lib/emscripten/system" \
	-DCMAKE_FIND_ROOT_PATH="/usr/lib/emscripten/system" \
	-DCMAKE_INSTALL_PREFIX="/usr/lib/emscripten/system" \
	# -DCMAKE_BUILD_TYPE=Release
	# -DCMAKE_INSTALL_PREFIX=/usr \

    make -j8
    make install
)
