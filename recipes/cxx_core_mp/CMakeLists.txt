cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_core_mp VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_core_mp)
  return()
endif()

# Build Options
#
option(CORE_MP_TEST "Compile cxx_core_mp tests" ${CORE_TEST})
option(CORE_MP_DOCS "Generate cxx_core_mp docs" ${CORE_DOCS})

# Build and install cxx-core-mp
#
ExternalProject_Add(cxx_core_mp
  PREFIX cxx_core_mp
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-mp
  GIT_TAG main
  GIT_SHALLOW TRUE
  STEP_TARGETS build
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORE_MP_TEST=${CORE_MP_TEST} -DCORE_MP_DOCS=${CORE_MP_DOCS}
  ../cxx_core_mp
  BUILD_COMMAND make -j8
  )

if(${CORE_MP_TEST})
  add_check_target(cxx_core_mp)
  add_dependencies(cxx_core_mp-build googletest)
endif()

add_dependencies(cxx_core_mp cxx_core_pp)
add_dependencies(cxx_depends_all cxx_core_mp)
