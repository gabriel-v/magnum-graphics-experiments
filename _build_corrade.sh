#!/bin/bash -ex

cd "$(dirname ${BASH_SOURCE[0]})"
cd lib/corrade
(
    rm -rf build
    mkdir build && cd build
    cmake .. \
	# -DCMAKE_BUILD_TYPE=Release

    cmake --build . -j8
    cmake --build . --target install
)

(
    rm -rf emscripten-build
    mkdir emscripten-build && cd emscripten-build
    cmake .. \
	-DCMAKE_TOOLCHAIN_FILE="$VIDEOGAME_EMSCRIPTEN_TOOLCHAIN" \
	-DCMAKE_INSTALL_PREFIX="$VIDEOGAME_INSTALL_LOCATION" \
	-DCORRADE_BUILD_STATIC=ON \
	# -DCMAKE_BUILD_TYPE=Release

    cmake --build . -j8
    cmake --build . --target install
)
