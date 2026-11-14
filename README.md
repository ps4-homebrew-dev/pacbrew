# pacbrew

Libraries for PS4 homebrew, packaged as Arch Linux style PKGBUILDs and built
with the [ps4-homebrew-dev SDK](https://github.com/ps4-homebrew-dev/sdk).

## Install
Each release bundles the SDK with all the libraries:
```sh
wget https://github.com/ps4-homebrew-dev/pacbrew/releases/latest/download/ps4-homebrew-dev.tar.gz
sudo tar xf ps4-homebrew-dev.tar.gz -C /
```

## Building
You'll need `makepkg` and `pacman`, plus the build tools listed in
[the CI workflow](.github/workflows/libs.yml). Then, just run:
```sh
./ci-libs.sh
```

## License
Each library keeps its own license, as named in its PKGBUILD.
