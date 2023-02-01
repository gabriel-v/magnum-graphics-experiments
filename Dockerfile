FROM python:3.11-bullseye
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update &&  apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8

RUN apt-get install -y pkg-config build-essential cmake curl wget vim emscripten \
debhelper  cmake   libgl-dev libopenal-dev libglfw3-dev libsdl2-dev
# libgl1 libopenal1 libglfw3 libsdl2-2.0-0

RUN mkdir /app
COPY lib /app/lib
WORKDIR /app
ADD requirements.txt .
RUN pip install -r requirements.txt

ADD _build_corrade.sh .
RUN ./_build_corrade.sh

ADD ./_build_magnum.sh .
RUN ./_build_magnum.sh

ADD ./_build_magnum_bindings.sh .
RUN ./_build_magnum_bindings.sh
