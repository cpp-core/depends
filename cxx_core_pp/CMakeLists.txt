cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx-core-pp VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_core_pp)
  return()
endif()

# Build and install cxx-core-pp
#
ExternalProject_Add(cxx_core_pp
  PREFIX cxx_core_pp
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-pp
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORE_PP_TEST=OFF -DCORE_PP_DOCS=OFF
  ../cxx_core_pp
  BUILD_COMMAND make -j8
  )
