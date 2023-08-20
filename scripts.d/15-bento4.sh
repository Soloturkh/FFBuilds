#!/bin/bash

SCRIPT_REPO="https://github.com/Soloturkh/bento4.git"
SCRIPT_COMMIT="e385097e016d6be7f04dea0d28ba26d1a7361998"

ffbuild_enabled() {
    [[ $VARIANT == lgpl* ]] && return -1
    return 0
}

ffbuild_dockerbuild() {
    cd "$FFBUILD_DLDIR/$SELF"

    local myconf=(
        --disable-cli
        --enable-static
        --enable-pic
        --disable-lavf
        --disable-swscale
        --prefix="$FFBUILD_PREFIX"
    )

    if [[ $TARGET == win* || $TARGET == linux* ]]; then
        myconf+=(
            --host="$FFBUILD_TOOLCHAIN"
            --cross-prefix="$FFBUILD_CROSS_PREFIX"
        )
    else
        echo "Unknown target"
        return -1
    fi

    ./configure "${myconf[@]}"
    make -j$(nproc)
    make install
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
