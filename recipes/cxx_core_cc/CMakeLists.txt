cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_core_cc VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_core_cc)
  return()
endif()

# Build Options
#
option(CORE_CC_TEST "Compile cxx_core_cc tests" ${CORE_TEST})
option(CORE_CC_DOCS "Generate cxx_core_cc docs" ${CORE_DOCS})

# Build and install cxx-core-util
#
ExternalProject_Add(cxx_core_cc
  PREFIX cxx_core_cc
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-cc
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORE_CC_TEST=${CORE_CC_TEST} -DCORE_CC_DOCS=${CORE_CC_DOCS}
  ../cxx_core_cc
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(cxx_core_cc)
add_dependencies(cxx_core_cc-depends cxx_coro_stream cxx_core_util fmt json)
add_dependencies(cxx_depends_all cxx_core_cc)

if(${CORE_CC_TEST})
  add_dependencies(cxx_core_cc-depends googletest)
endif()
