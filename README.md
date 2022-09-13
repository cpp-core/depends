[![Build](https://github.com/melton1968/cxx-depends/actions/workflows/build.yaml/badge.svg)](https://github.com/melton1968/cxx-depends/actions/workflows/build.yaml)
[![cxx-core-pp](https://github.com/melton1968/cxx-depends/actions/workflows/build_cxx_core_pp.yaml/badge.svg)](https://github.com/melton1968/cxx-depends/actions/workflows/build_cxx_core_pp.yaml)
[![cxx-core-mp](https://github.com/melton1968/cxx-depends/actions/workflows/build_cxx_core_mp.yaml/badge.svg)](https://github.com/melton1968/cxx-depends/actions/workflows/build_cxx_core_mp.yaml)
[![cxx-core-tuple](https://github.com/melton1968/cxx-depends/actions/workflows/build_cxx_core_tuple.yaml/badge.svg)](https://github.com/melton1968/cxx-depends/actions/workflows/build_cxx_core_tuple.yaml)
[![cxx-core-fp](https://github.com/melton1968/cxx-depends/actions/workflows/build_cxx_core_fp.yaml/badge.svg)](https://github.com/melton1968/cxx-depends/actions/workflows/build_cxx_core_fp.yaml)
[![cxx-coro-stream](https://github.com/melton1968/cxx-depends/actions/workflows/build_cxx_coro_stream.yaml/badge.svg)](https://github.com/melton1968/cxx-depends/actions/workflows/build_cxx_coro_stream.yaml)

# Simple C++ CMake Dependency Management

## TLDR;

`cxx-depends` provides a simple CMake framework for managing external c++ dependencies. 

## Dependencies

- `libbz2` bzip2 compression library and tools
- `cpr` C++ Requests: Curl for people
- `date` Implementation of C++20 date enhancements.
- `fmt` Fast and safe alternative to C stdio and C++ iostreams
- `googletest` Google's C++ Test Framework
- `json` First class JSON for C++
- `spdlog` C++ logging library
- `xsimd` SIMD Intrinsics
- `xtl` Containers and Algorithms used by XSIMD and XTensor.
- `xtensor` Multi-dimensional Arrays with Broadcasting and Lazy Evaluation
- `libzmq` ZeroMQ Messaging Kernel Library
- `cppzmq` High-level C++ Binding for ZeroMQ
- `zstd` Zstandard Fast Real-Time Compression Algorithm


## Usage

In a convenient location:
```
cd ~/mydir/
git clone git@github.com:melton1968/cxx-depends
mkdir cxx-depends/build && cd cxx_depends/build
cmake .. -DCMAKE_INSTALL_PREFIX=~/mydir/cxx_install
make zstd
```
The ZSTD library and headers are now installed in `~/mydir/cxx_install`

