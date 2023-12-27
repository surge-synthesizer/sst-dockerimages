FROM ubuntu:20.04
ENV LANG C.UTF-8

ARG JOBS
ARG CTNG_VERSION=1.26.0
#ARG DEBIAN_FRONTEND=noninteractive

# Non-interactive configuration of tzdata
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
RUN { echo 'tzdata tzdata/Areas select Etc'; echo 'tzdata tzdata/Zones/Etc select UTC'; } | debconf-set-selections

# Create unprivileged user to build toolchains and plugins
RUN groupadd -g 1000 build
RUN useradd --create-home --uid 1000 --gid 1000 --shell /bin/bash build

USER build
RUN mkdir -p /home/build/arm-toolchain
WORKDIR /home/build/arm-toolchain

# Get crosstool-ng
USER root
RUN mkdir -p /home/root/ctng-area
WORKDIR /home/root/ctng-area
RUN apt-get update
RUN apt-get install -y wget tar 
RUN wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-${CTNG_VERSION}.tar.bz2
RUN tar -xf crosstool-ng-${CTNG_VERSION}.tar.bz2
 

# and install it
RUN apt-get install -y gcc g++ gperf bison flex texinfo help2man make libncurses5-dev \
    python3-dev autoconf automake libtool libtool-bin gawk wget bzip2 xz-utils unzip \
    patch libstdc++6 rsync git meson ninja-build

RUN cd crosstool-ng-${CTNG_VERSION} && ./configure
RUN cd crosstool-ng-${CTNG_VERSION} && make
RUN cd crosstool-ng-${CTNG_VERSION} && make install

# Then install the prerequistes for a juce build
RUN apt-get install -y git vim 
RUN apt-get install -y cmake ninja-build 
RUN apt-get install -y \
              devscripts \
              libxcb-cursor-dev \
              libxcb-keysyms1-dev \
              libxcb-util-dev \
              libxkbcommon-dev \
              libxkbcommon-x11-dev \
              xcb \
              libgtk-3-dev \
              libwebkit2gtk-4.0 \
              libwebkit2gtk-4.0-dev \
              libcurl4-openssl-dev \
              alsa \
              alsa-tools \
              libasound2-dev \
              libjack-dev \
              libfreetype6-dev \
              libxinerama-dev \
              libxcb-xinerama0 \
              libxinerama1 \
              x11proto-xinerama-dev \
              libxrandr-dev \
              libgl1-mesa-dev \
              libxcursor-dev \
              libxcursor1 \
              libxcb-cursor-dev \
              libxcb-cursor0


# Switch back go the user space user and build the toolchain
USER build
WORKDIR /home/build/arm-toolchain
COPY aarch64-rpi4-linux-gnu-gcc11-glibc231.conf .config
RUN ct-ng build

# Finally set up the state for the arm build
RUN mkdir /home/build/dev
WORKDIR /home/build/dev
ENV PATH="${PATH}:/home/build/x-tools/aarch64-rpi4-linux-gnu/bin/"
