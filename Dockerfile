FROM python:3.11-bullseye
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update &&  apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8

RUN apt-get install -y pkg-config build-essential cmake curl wget vim emscripten \
debhelper  cmake   libgl-dev libopenal-dev libglfw3-dev libsdl2-dev \
libegl1-mesa-dev libegl1 libegl-dev
# libgl1 libopenal1 libglfw3 libsdl2-2.0-0

RUN mkdir /app
COPY lib /app/lib
WORKDIR /app
# ADD requirements.txt .
# RUN pip install -r requirements.txt


#          INSTALL PYTHON WASM IMPLEMENTATIONS
# ======================================================
RUN git clone --depth 1 --branch 3.11 https://github.com/python/cpython.git lib/python-wasm/cpython
RUN mkdir -p lib/python-wasm/cpython/builddir/build
RUN mkdir -p lib/python-wasm/cpython/builddir/emscripten-browser
RUN mkdir -p lib/python-wasm/cpython/builddir/emscripten-node
RUN cd ./lib/python-wasm/ && ./build-python-build.sh
RUN cd ./lib/python-wasm/ && ./build-python-emscripten-browser.sh

# RUN mkdir -p lib/python-wasm/cpython/builddir/wasi
# RUN cd ./lib/python-wasm/ && ./build-python-wasi.sh
# RUN cd ./lib/python-wasm/ && ./build-python-emscripten-node.sh
RUN cp -r lib/python-wasm/cpython/builddir/emscripten-browser $VIDEOGAME_INSTALL_LOCATION/python-wasm

#          INSTALL MAGNUM GRAPHICS NORMAL IMPLEMENTATIONS
# ====================================================== ======
ENV VIDEOGAME_INSTALL_LOCATION=/app/install_normal
ENV VIDEOGAME_EMSCRIPTEN_TOOLCHAIN=
# ENV VIDEOGAME_EMSCRIPTEN_TOOLCHAIN /app/lib/toolchains/generic/Emscripten.cmake

ADD ./_build_corrade.sh .
RUN ./_build_corrade.sh

ADD ./_build_magnum.sh .
RUN ./_build_magnum.sh

ADD ./_build_magnum_plugins.sh .
RUN ./_build_magnum_plugins.sh

ADD ./_build_pybind11.sh .
RUN ./_build_pybind11.sh

ADD ./_build_magnum_bindings.sh .
RUN ./_build_magnum_bindings.sh


#          INSTALL MAGNUM GRAPHICS WASM IMPLEMENTATIONS
# ======================================================
ENV VIDEOGAME_INSTALL_LOCATION=/app/install_emscripten
ENV VIDEOGAME_EMSCRIPTEN_TOOLCHAIN=/app/lib/toolchains/generic/Emscripten-wasm.cmake
# ENV VIDEOGAME_EMSCRIPTEN_TOOLCHAIN /app/lib/toolchains/generic/Emscripten.cmake

ADD ./_build_corrade.sh .
RUN ./_build_corrade.sh

ADD ./_build_magnum.sh .
RUN ./_build_magnum.sh

ADD ./_build_magnum_plugins.sh .
RUN ./_build_magnum_plugins.sh

ADD ./_build_pybind11.sh .
RUN ./_build_pybind11.sh

ADD ./_build_magnum_bindings.sh .
RUN ./_build_magnum_bindings.sh || true


ENV PS2="videogame$ "
