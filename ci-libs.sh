#!/usr/bin/env bash

SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${SCRIPT_PATH}")"

PKGS=(sdk openlibm zlib libcxx bzip2 dht enet expat faad2
      fast_float fmt freetype fontconfig giflib glm harfbuzz jansson lame
      lexbor libb64 libconfig libdeflate libfribidi libass libiconv libmad
      libmicrodns libminizip libmodplug libmpeg2 libnatpmp
      libnfs libogg flac libpng libpsl libsamplerate libsmb2 libsodium
      libtheora libutp libvorbis libyuv lz4 miniupnpc mpg123
      json-c libevent libjpeg-turbo libquickjs libvpx libwebp lua luajit
      openssl curl libssh libssh2 opus libsndfile sqlite tinyxml2 xz
      libxml2 yaml-cpp zstd libarchive libzip mesa vulkan-headers ffmpeg
      SDL2 SDL2_ttf SDL2_net SDL2_mixer SDL2_image SDL2_gfx SDL2_kitchensink)

sudo pacman --noconfirm --remove ps4-homebrew-dev

for PKG in ${PKGS[*]} ; do
    pushd $PKG || exit 1
    rm -f *.pkg.tar.gz
    rm -rf src pkg
    makepkg -c -f -C || exit 1
    sudo pacman \
	 --config "${SCRIPT_DIR}/pacman.conf" \
	 --noconfirm -U ./ps4-homebrew-*.pkg.tar.gz || exit 1
    popd
done
