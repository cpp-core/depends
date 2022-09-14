cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_ply VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_ply)
  return()
endif()

# Build Options
#
option(PLY_TEST "Compile cxx_ply tests" ${CORE_TEST})
option(PLY_DOCS "Generate cxx_ply docs" ${CORE_DOCS})

# Build and install cxx-core-util
#
ExternalProject_Add(cxx_ply
  PREFIX cxx_ply
  GIT_REPOSITORY git@github.com:melton1968/cxx-ply
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DPLY_TEST=${PLY_TEST} # -DPLY_DOCS=${PLY_DOCS}
  ../cxx_ply
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(cxx_ply)
add_dependencies(cxx_ply-depends cxx_core_mp cxx_core_string cxx_core_util inja json)
add_dependencies(cxx_depends_all cxx_ply)

if(${PLY_TEST})
  add_dependencies(cxx_ply-depends googletest)
endif()
