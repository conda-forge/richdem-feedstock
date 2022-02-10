# export CXXFLAGS="-std=c++11"
export CXXFLAGS="-std=c++17"
export MACOSX_DEPLOYMENT_TARGET="10.15"

mkdir _build && cd _build
cmake .. -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release -DUSE_GDAL=ON -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15
make all -j$CPU_COUNT
make install

cd ../wrappers/pyrichdem && python -m pip install . --no-deps -vv
