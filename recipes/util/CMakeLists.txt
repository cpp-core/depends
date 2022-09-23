cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(util VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET util)
  return()
endif()

# Build Options
#
option(UTIL_TEST "Compile util tests" ${ALL_TEST})
option(UTIL_DOCS "Generate util docs" ${ALL_DOCS})

# Build and install cxx-core-util
#
ExternalProject_Add(util
  PREFIX util
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-util
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DUTIL_TEST=${UTIL_TEST} -DUTIL_DOCS=${UTIL_DOCS}
  ../util
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(util)
add_dependencies(util-depends stream string fmt json)
add_dependencies(depends_all util)

if(${UTIL_TEST})
  add_dependencies(util-depends googletest)
endif()


