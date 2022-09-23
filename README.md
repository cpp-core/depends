[![Build](https://github.com/cpp-core/depends/actions/workflows/build.yaml/badge.svg)](https://github.com/cpp-core/depends/actions/workflows/build.yaml)
[![fp](https://github.com/cpp-core/depends/actions/workflows/build_cc.yaml/badge.svg)](https://github.com/cpp-core/depends/actions/workflows/build_fcc.yaml)
[![fp](https://github.com/cpp-core/depends/actions/workflows/build_chrono.yaml/badge.svg)](https://github.com/cpp-core/depends/actions/workflows/build_chrono.yaml)
[![fp](https://github.com/cpp-core/depends/actions/workflows/build_fp.yaml/badge.svg)](https://github.com/cpp-core/depends/actions/workflows/build_fp.yaml)
[![mp](https://github.com/cpp-core/depends/actions/workflows/build_mp.yaml/badge.svg)](https://github.com/cpp-core/depends/actions/workflows/build_mp.yaml)
[![pp](https://github.com/cpp-core/depends/actions/workflows/build_pp.yaml/badge.svg)](https://github.com/cpp-core/depends/actions/workflows/build_pp.yaml)
[![string](https://github.com/cpp-core/depends/actions/workflows/build_string.yaml/badge.svg)](https://github.com/cpp-core/depends/actions/workflows/build_string.yaml)
[![tuple](https://github.com/cpp-core/depends/actions/workflows/build_tuple.yaml/badge.svg)](https://github.com/cpp-core/depends/actions/workflows/build_tuple.yaml)
[![util](https://github.com/cpp-core/depends/actions/workflows/build_util.yaml/badge.svg)](https://github.com/cpp-core/depends/actions/workflows/build_util.yaml)
[![cxx-coro-stream](https://github.com/cpp-core/depends/actions/workflows/build_stream.yaml/badge.svg)](https://github.com/cpp-core/depends/actions/workflows/build_stream.yaml)
[![cxx-ply](https://github.com/cpp-core/depends/actions/workflows/build_ply.yaml/badge.svg)](https://github.com/cpp-core/depends/actions/workflows/build_ply.yaml)

# Basic C++ Package Management

A CMake framework for managing C++ packages.

## At A Glance

### External libraries

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

### cpp-core family libraries

- `cc` Structured concurrency library.
- `chrono` Date and Time library.
- `codec` Codecs for base64, zstd and bzip2.
- `fp` Function programming library.
- `mp` Metaprogramming library.
- `pp` Structured preprocessor programming.
- `strand` Cooperative multitasking library using co-routines.
- `stream` Streams library using co-routines.
- `string` String library.
- `tuple` Tuple library.
- `util` Utility library.

## Usage

In a convenient location:
```
cd ~/mydir/
git clone https://github.com/cpp-core/depends
mkdir depends/build && cd cxx_depends/build
cmake .. -DCMAKE_INSTALL_PREFIX=~/mydir/opt
make zstd
```
The ZSTD library and headers are now installed in `~/mydir/opt`

