cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_xtensor VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET xtensor)
  return()
endif()

# Build and install xtensor
#
ExternalProject_Add(xtensor
  PREFIX cxx_xtensor
  GIT_REPOSITORY git@github.com:melton1968/xtensor.git
  GIT_TAG clang11-workaround
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../xtensor
  BUILD_COMMAND make -j8
  )

add_dependencies(xtensor xtl xsimd)
add_dependencies(depends_all xtensor)
