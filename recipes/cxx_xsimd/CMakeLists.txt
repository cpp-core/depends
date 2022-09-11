cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_xsimd VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET xsimd)
  return()
endif()

# Build and install cxx_xsimd
#
ExternalProject_Add(xsimd
  PREFIX cxx_xsimd
  GIT_REPOSITORY git@github.com:melton1968/xsimd.git
  GIT_TAG 7.6.0
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../xsimd
  BUILD_COMMAND make -j8
  )

add_dependencies(cxx_depends_all xsimd)
