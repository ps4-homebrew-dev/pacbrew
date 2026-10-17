#!/usr/bin/env bash

SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${SCRIPT_PATH}")"

PKGS=(sdk zlib libcxx mesa vulkan-headers)

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
