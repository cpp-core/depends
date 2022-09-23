cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(tuple VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET tuple)
  return()
endif()

# Build Options
#
option(TUPLE_TEST "Compile tuple tests" ${ALL_TEST})
option(TUPLE_DOCS "Generate tuple docs" ${ALL_DOCS})

# Build and install cxx-core-tuple
#
ExternalProject_Add(tuple
  PREFIX tuple
  GIT_REPOSITORY git@github.com:cpp-core/tuple
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DTUPLE_TEST=${TUPLE_TEST} -DTUPLE_DOCS=${TUPLE_DOCS}
  ../tuple
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(tuple)
add_dependencies(tuple-depends mp)
add_dependencies(depends_all tuple)

if(${TUPLE_TEST})
  add_dependencies(tuple-depends googletest)
endif()
