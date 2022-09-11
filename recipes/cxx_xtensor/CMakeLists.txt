cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_xtensor VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_xtensor)
  return()
endif()

# Build and install cxx_xtensor
#
ExternalProject_Add(cxx_xtensor
  PREFIX cxx_xtensor
  GIT_REPOSITORY git@github.com:melton1968/xtensor.git
  GIT_TAG clang11-workaround
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../cxx_xtensor
  BUILD_COMMAND make -j8
  )

add_dependencies(cxx_xtensor cxx_xtl cxx_xsimd)
add_dependencies(cxx_depends_all cxx_xtensor)
