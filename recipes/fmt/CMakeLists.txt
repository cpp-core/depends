cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_fmt VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET fmt)
  return()
endif()

# Build and install fmt
#
ExternalProject_Add(fmt
  PREFIX cxx_fmt
  GIT_REPOSITORY https://github.com/cpp-core/fmt
  GIT_TAG 9.1.0
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=-stdlib=libc++ ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DFMT_DOC=OFF -DFMT_TEST=OFF -DFMT_FUZZ=OFF ../fmt
  BUILD_COMMAND make -j8
  )

add_dependencies(depends_all fmt)
