cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(ply VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET ply)
  return()
endif()

# Build Options
#
option(PLY_TEST "Compile ply tests" ${ALL_TEST})
option(PLY_DOCS "Generate ply docs" ${ALL_DOCS})

# Build and install ply
#
ExternalProject_Add(ply
  PREFIX ply
  GIT_REPOSITORY https://github.com/cpp-core/ply
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DPLY_TEST=${PLY_TEST} # -DPLY_DOCS=${PLY_DOCS}
  ../ply
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(ply)
add_dependencies(ply-depends mp string util inja json)
add_dependencies(depends_all ply)

if(${PLY_TEST})
  add_dependencies(ply-depends googletest)
endif()
