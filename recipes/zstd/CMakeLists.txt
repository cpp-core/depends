cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_zstd VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET zstd)
  return()
endif()

# Build and install zstd
#
ExternalProject_Add(zstd
  PREFIX zstd
  GIT_REPOSITORY https://github.com/cpp-core/zstd.git
  GIT_TAG v1.5.2
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../zstd/build/cmake
  BUILD_COMMAND make -j8
  )

add_dependencies(depends_all zstd)
