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
  PREFIX cxx_zstd
  GIT_REPOSITORY git@github.com:melton1968/zstd.git
  GIT_TAG 1c700d1d50e3b50c533ac22a5279b1936d4d70ee
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../zstd/build/cmake
  BUILD_COMMAND make -j8
  )

add_dependencies(depends_all zstd)
