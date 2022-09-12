cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_core_tuple VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_core_tuple)
  return()
endif()

# Build Options
#
option(CORE_TUPLE_TEST "Compile cxx_core_tuple tests" ${CORE_TEST})
option(CORE_TUPLE_DOCS "Generate cxx_core_tuple docs" ${CORE_DOCS})

# Build and install cxx-core-tuple
#
ExternalProject_Add(cxx_core_tuple
  PREFIX cxx_core_tuple
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-tuple
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORE_TUPLE_TEST=${CORE_TUPLE_TEST} -DCORE_TUPLE_DOCS=${CORE_TUPLE_DOCS}
  ../cxx_core_tuple
  BUILD_COMMAND make -j8
  )

if(${CORE_TUPLE_TEST})
  add_check_target(cxx_core_tuple)
  add_dependencies(cxx_core_tuple-build googletest)
endif()

add_dependencies(cxx_core_tuple-build cxx_core_mp)
add_dependencies(cxx_depends_all cxx_core_tuple)
