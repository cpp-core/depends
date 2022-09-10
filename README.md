[![Build](https://github.com/melton1968/cxx-depends/actions/workflows/build.yaml/badge.svg)](https://github.com/melton1968/cxx-depends/actions/workflows/build.yaml)

# cxx-depends: Simple C++ CMake Dependency Management

## TLDR;

`cxx-depends` provides a simple CMake framework for managing external c++ dependencies. 

## Dependencies
- `google_cloud_cpp` Google's BigTable Library
- `cxx_bzip2` bzip2 compression library and tools
- `cxx_tensorflow_c_api` Tensorflow's C API library
- `cxx_cppflow` C++ wrapper for Tensorflow's C API library
- `cxx_cpr` C++ Requests: Curl for people
- `cxx_date` Implementation of C++20 date enhancements.
- `cxx_fmt` Fast and safe alternative to C stdio and C++ iostreams
- `cxx_googletest` Google's C++ Test Framework
- `cxx_libmicrohttpd` HTTP 1.1 Web Server used by HTTPServer
- `cxx_httpserver` RESTful Web Server Framework
- `cxx_inja` Template engine
- `cxx_ixwebsocket` Client and Server WebSocket Library
- `cxx_json` First class JSON for C++
- `cxx_spdlog` C++ logging library
- `cxx_termox` Terminal User Interface Framework
- `cxx_xml` XML Processing Library
- `cxx_xsimd` SIMD Intrinsics
- `cxx_xtl` Containers and Algorithms used by XSIMD and XTensor.
- `cxx_xtensor` Multi-dimensional Arrays with Broadcasting and Lazy Evaluation
- `cxx_libzmq` ZeroMQ Messaging Kernel Library
- `cxx_cppzmq` High-level C++ Binding for ZeroMQ
- `cxx_zstd` Zstandard Fast Real-Time Compression Algorithm


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
