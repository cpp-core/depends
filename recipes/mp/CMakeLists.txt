cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(mp VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET mp)
  return()
endif()

# Build Options
#
option(MP_TEST "Compile mp tests" ${ALL_TEST})
option(MP_DOCS "Generate mp docs" ${ALL_DOCS})

# Build and install cxx-core-mp
#
ExternalProject_Add(mp
  PREFIX mp
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-mp
  GIT_TAG main
  GIT_SHALLOW TRUE
  STEP_TARGETS build
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DMP_TEST=${MP_TEST} -DMP_DOCS=${MP_DOCS}
  ../mp
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(mp)
add_dependencies(mp-depends pp fmt)
add_dependencies(depends_all mp)

if(${MP_TEST})
  add_dependencies(mp-depends googletest)
endif()
