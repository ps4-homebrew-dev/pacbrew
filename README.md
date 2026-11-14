# pacbrew

Libraries for PS4 homebrew, built with the
[ps4-homebrew-dev SDK](https://github.com/ps4-homebrew-dev/sdk): one
directory per library, each with an Arch Linux style `PKGBUILD` (and the
patches the console needs). Among them are SDL2 with a PS4 port (video,
audio, the DualShock 4, HDMI-CEC remote keys), Mesa (OpenGL, OpenGL ES and
Vulkan), FFmpeg, mpv, libplacebo, RmlUi, curl, OpenSSL, and many smaller
ones.

## Installing
Each [release](https://github.com/ps4-homebrew-dev/pacbrew/releases) is the
SDK and every library, built, in one archive that unpacks to
`/opt/ps4-homebrew-sdk`:

```sh
wget https://github.com/ps4-homebrew-dev/pacbrew/releases/latest/download/ps4-homebrew-dev.tar.gz
sudo tar xf ps4-homebrew-dev.tar.gz -C /
```

The libraries are in `/opt/ps4-homebrew-sdk/target/usr`, where
`orbis-pkg-config`, `orbis-cmake` and `orbis-meson` find them.

## Building
The packages are built with `makepkg` and installed with `pacman`, so that
each one finds the ones it depends on. On Ubuntu that needs the
`makepkg` and `pacman-package-manager` packages, LLVM/Clang 20, and the
build tools the libraries use; `.github/workflows/libs.yml` lists them all.

```sh
bash ci-libs.sh
```

builds and installs every package in dependency order (the list is in the
script), starting with the SDK itself. One package, once its dependencies
are installed:

```sh
cd zlib
makepkg -c -f -C
sudo pacman --config ../pacman.conf --noconfirm -U ./ps4-homebrew-*.pkg.tar.gz
```

`PS4_HOMEBREW_SDK` says where the SDK is, `/opt/ps4-homebrew-sdk` if unset.

## Adding a library
Copy the `PKGBUILD` of a library built the same way (autotools, CMake or
Meson), and change the name, version, source and checksum. Name the package
`ps4-homebrew-<library>`, put it in the `ps4-homebrew-dev` group, build
static libraries unless the library has to be a shared one (as Mesa's
drivers are), and install into `${pkgdir}/${SYSROOT}`. Then add it
to `PKGS` in `ci-libs.sh`, after what it depends on.

## License
Each library keeps its own license, which its `PKGBUILD` names; the
patches here are under the license of the library they change.
