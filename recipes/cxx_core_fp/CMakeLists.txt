cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_core_fp VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_core_fp)
  return()
endif()

# Build Options
#
option(CORE_FP_TEST "Compile cxx_core_fp tests" ${CORE_TEST})
option(CORE_FP_DOCS "Generate cxx_core_fp docs" ${CORE_DOCS})

# Build and install cxx-core-fp
#
ExternalProject_Add(cxx_core_fp
  PREFIX cxx_core_fp
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-fp
  GIT_TAG main
  GIT_SHALLOW TRUE
  STEP_TARGETS build
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORE_FP_TEST=${CORE_FP_TEST} -DCORE_FP_DOCS=${CORE_FP_DOCS}
  ../cxx_core_fp
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(cxx_core_fp)
add_dependencies(cxx_core_fp-depends cxx_core_mp)
add_dependencies(cxx_depends_all cxx_core_fp)

if(${CORE_FP_TEST})
  add_dependencies(cxx_core_fp-depends googletest)
endif()
