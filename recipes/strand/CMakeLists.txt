cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(strand VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET strand)
  return()
endif()

# Build Options
#
option(STRAND_TEST "Compile strand tests" ${ALL_TEST})
option(STRAND_DOCS "Generate strand docs" ${ALL_DOCS})

# Build and install cxx-coro-strand
#
ExternalProject_Add(strand
  PREFIX strand
  GIT_REPOSITORY https://github.com/cpp-core/strand
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DSTRAND_TEST=${STRAND_TEST} -DSTRAND_DOCS=${STRAND_DOCS}
  ../strand
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(strand)
add_dependencies(strand-depends chrono mp tuple fmt)
add_dependencies(depends_all strand)

if(${STRAND_TEST})
  add_dependencies(strand-depends googletest)
endif()


