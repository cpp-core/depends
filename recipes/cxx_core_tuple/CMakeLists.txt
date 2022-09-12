cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_core_tuple VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_core_tuple)
  return()
endif()

# Build and install cxx-core-tuple
#
ExternalProject_Add(cxx_core_tuple
  PREFIX cxx_core_tuple
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-tuple
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORE_TUPLE_TEST=OFF -DCORE_TUPLE_DOCS=OFF
  ../cxx_core_tuple
  BUILD_COMMAND make -j8
  )

add_dependencies(cxx_core_tuple cxx_core_mp)
add_dependencies(cxx_depends_all cxx_core_tuple)
