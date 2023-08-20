#!/bin/bash

SCRIPT_REPO="https://github.com/Soloturkh/bento4.git"
SCRIPT_COMMIT="e385097e016d6be7f04dea0d28ba26d1a7361998"

ffbuild_enabled() {
    [[ $VARIANT == lgpl* ]] && return -1
    return 0
}

ffbuild_dockerbuild() {
    cd "$FFBUILD_DLDIR/$SELF"

    mkdir build && cd build

    cmake -DCMAKE_TOOLCHAIN_FILE="$FFBUILD_CMAKE_TOOLCHAIN" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX="$FFBUILD_PREFIX" ..

    make
}

ffbuild_configure() {
    echo --enable-libbento4
}

ffbuild_unconfigure() {
    echo --disable-libbento4
}

ffbuild_cflags() {
    return 0
}

ffbuild_ldflags() {
    return 0
}
