#!/bin/bash -ex

cd "$(dirname ${BASH_SOURCE[0]})"
cd lib/magnum-bindings
(
    rm -rf build
    mkdir build && cd build

    sed -i.bak 's|^#error "LONG_BIT|// #error "LONG_BIT|g' /usr/local/include/python3.11/pyport.h

    cmake .. \
	-DCMAKE_TOOLCHAIN_FILE="$VIDEOGAME_EMSCRIPTEN_TOOLCHAIN" \
	-DMAGNUM_WITH_PYTHON=ON \
	-DMAGNUM_BUILD_STATIC=ON \
	-DCMAKE_CROSSCOMPILING=ON \
	-DCMAKE_PREFIX_PATH="$VIDEOGAME_INSTALL_LOCATION;/usr/local;/usr" \
	-DCMAKE_FIND_ROOT_PATH="$VIDEOGAME_INSTALL_LOCATION" \
	-DCMAKE_INSTALL_PREFIX="$VIDEOGAME_INSTALL_LOCATION" \
	# -DCMAKE_FIND_ROOT_PATH="/usr/lib/emscripten/system"
	# -DCMAKE_BUILD_TYPE=Release \
	# -DCMAKE_SYSTEM_NAME=wasm32-unknown-emscripten \

    make -j8
    make install
    cd src/python
    python setup.py install
)

# cd lib/magnum-bindings
# (
#     rm -rf build-normal
#     mkdir build-normal && cd build-normal
# 
#     # sed -i.bak 's|^#error "LONG_BIT|// #error "LONG_BIT|g' /usr/local/include/python3.11/pyport.h
# 
#     cmake .. \
# 	-DMAGNUM_WITH_PYTHON=ON \
# 	-DMAGNUM_BUILD_STATIC=ON \
# 	-DCMAKE_CROSSCOMPILING=ON \
# 	-DCMAKE_PREFIX_PATH="$VIDEOGAME_INSTALL_LOCATION;/usr/local;/usr" \
# 	-DCMAKE_FIND_ROOT_PATH="$VIDEOGAME_INSTALL_LOCATION" \
# 	-DCMAKE_INSTALL_PREFIX="$VIDEOGAME_INSTALL_LOCATION" \
# 	# -DCMAKE_TOOLCHAIN_FILE="$VIDEOGAME_EMSCRIPTEN_TOOLCHAIN" \
# 	# -DCMAKE_FIND_ROOT_PATH="/usr/lib/emscripten/system"
# 	# -DCMAKE_BUILD_TYPE=Release \
# 	# -DCMAKE_SYSTEM_NAME=wasm32-unknown-emscripten \
# 
#     make -j8
#     make install
#     cd src/python/magnum
#     python setup.py install
# )
