# cxx-depends: Simple C++ CMake Dependency Management

## TLDR;

cxx-depends provides a simple CMake framework for managing external c++ dependencies.

## Usage - Standalone
In a convenient location:
```
cd ~/mydir/
git clone git@github.com:melton1968/cxx-depends
mkdir cxx-depends/build && cd cxx_depends/build
cmake .. -DDEPENDS_TARGET_DIR=~/mydir/cxx_install
make cxx_zstd
```

The ZSTD library and headers are now installed in `~/mydir/cxx_install`


## Usage - As Submodule

In your source tree:
```
git submodule add git@github.com:melton1968/cxx-depends extern/cxx-depends
git submodule init
```

In CMakeLists.txt:
```
add_subdirectory(extern/cxx-depends)
include(${DEPENDS_SOURCE_DIR)/zstd.cmake)
target_link_libraries(mylib PUBLIC zstd)
```
