#!/bin/bash -ex

cd "$(dirname ${BASH_SOURCE[0]})"
cd lib/pybind11
(
    rm -rf build
    mkdir build && cd build
	# -DMAGNUM_WITH_SDL2APPLICATION=ON \
	# -DCMAKE_SYSTEM_NAME=wasm32-unknown-emscripten \

    cmake .. \
	-DCMAKE_TOOLCHAIN_FILE="$VIDEOGAME_EMSCRIPTEN_TOOLCHAIN" \
	-DCMAKE_CROSSCOMPILING=ON \
	-DPYBIND11_TEST= \
	-DCMAKE_PREFIX_PATH="$VIDEOGAME_INSTALL_LOCATION;/usr/local;/usr/share;/usr/lib" \
	-DCMAKE_FIND_ROOT_PATH="$VIDEOGAME_INSTALL_LOCATION" \
	-DCMAKE_INSTALL_PREFIX="$VIDEOGAME_INSTALL_LOCATION"

    make -j8
    make install
)
