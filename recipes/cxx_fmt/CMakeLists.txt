cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_fmt VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_fmt)
  return()
endif()

# Build and install cxx-core-pp
#
ExternalProject_Add(cxx_fmt
  PREFIX cxx_fmt
  GIT_REPOSITORY git@github.com:melton1968/fmt
  GIT_TAG 7.1.3
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=-stdlib=libc++ ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DFMT_DOC=OFF -DFMT_TEST=OFF -DFMT_FUZZ=OFF ../cxx_fmt
  BUILD_COMMAND make -j8
  )

add_dependencies(cxx_depends_all cxx_fmt)
