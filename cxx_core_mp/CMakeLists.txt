cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_core_mp VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_core_mp)
  return()
endif()

# Build and install cxx-core-pp
#
ExternalProject_Add(cxx_core_mp
  PREFIX cxx_core_mp
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-mp
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORE_MP_TEST=OFF -DCORE_MP_DOCS=OFF
  ../cxx_core_mp
  BUILD_COMMAND make -j8
  )

add_dependencies(cxx_core_mp cxx_core_pp)
