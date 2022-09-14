cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_core_util VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_core_util)
  return()
endif()

# Build Options
#
option(CORE_UTIL_TEST "Compile cxx_core_util tests" ${CORE_TEST})
option(CORE_UTIL_DOCS "Generate cxx_core_util docs" ${CORE_DOCS})

# Build and install cxx-core-util
#
ExternalProject_Add(cxx_core_util
  PREFIX cxx_core_util
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-util
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORE_UTIL_TEST=${CORE_UTIL_TEST} -DCORE_UTIL_DOCS=${CORE_UTIL_DOCS}
  ../cxx_core_util
  BUILD_COMMAND make -j8
  )

if(${CORE_UTIL_TEST})
  add_check_target(cxx_core_util)
  add_dependencies(cxx_core_util-build googletest)
endif()

add_dependencies(cxx_core_util-build cxx_coro_stream fmt json)
add_dependencies(cxx_depends_all cxx_core_util)
