#!/bin/bash


set -ex

# strip std settings from conda
CXXFLAGS="${CXXFLAGS/-std=c++14/}"
CXXFLAGS="${CXXFLAGS/-std=c++11/}"
export CXXFLAGS

if [ "$target_platform" = "osx-arm64" ]; then
  export CMAKE_OSX_ARCHITECTURES="arm64"
  rm -rf $BUILD_PREFIX/bin/x86_64-*
fi



mkdir _build && cd _build
cmake ${CMAKE_ARGS} .. \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_BUILD_TYPE=Release \
  -DUSE_GDAL=ON

make all -j$CPU_COUNT
make install

cd ../wrappers/pyrichdem && ${PYTHON} -m pip install . --no-deps -vv
