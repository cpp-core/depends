cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(fp VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET fp)
  return()
endif()

# Build Options
#
option(FP_TEST "Compile fp tests" ${ALL_TEST})
option(FP_DOCS "Generate fp docs" ${ALL_DOCS})

# Build and install cxx-core-fp
#
ExternalProject_Add(fp
  PREFIX fp
  GIT_REPOSITORY https://github.com/cpp-core/fp
  GIT_TAG main
  GIT_SHALLOW TRUE
  STEP_TARGETS build
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DFP_TEST=${FP_TEST} -DFP_DOCS=${FP_DOCS}
  ../fp
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(fp)
add_dependencies(fp-depends mp)
add_dependencies(depends_all fp)

if(${FP_TEST})
  add_dependencies(fp-depends googletest)
endif()
