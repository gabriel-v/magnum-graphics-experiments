#!/bin/bash -ex

cd "$(dirname ${BASH_SOURCE[0]})"
cd lib/magnum-bindings
(
rm -rf build
mkdir build && cd build
    cmake .. \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DMAGNUM_WITH_PYTHON=ON \
	-DCMAKE_TOOLCHAIN_FILE="/app/lib/toolchains/generic/Emscripten-wasm.cmake" \
	-DCMAKE_PREFIX_PATH="/usr/lib/emscripten/system;/usr/local;/usr" \
	-DCMAKE_FIND_ROOT_PATH="/usr/lib/emscripten/system"
	# -DCMAKE_FIND_ROOT_PATH="/usr/lib/emscripten/system"
	# -DCMAKE_BUILD_TYPE=Release \

    make -j8
    make install
    cd src/python/magnum
    python setup.py install
)
