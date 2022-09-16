cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_coro_strand VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_coro_strand)
  return()
endif()

# Build Options
#
option(CORO_STRAND_TEST "Compile cxx_coro_strand tests" ${CORE_TEST})
option(CORO_STRAND_DOCS "Generate cxx_coro_strand docs" ${CORE_DOCS})

# Build and install cxx-coro-strand
#
ExternalProject_Add(cxx_coro_strand
  PREFIX cxx_coro_strand
  GIT_REPOSITORY git@github.com:melton1968/cxx-coro-strand
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORO_STRAND_TEST=${CORO_STRAND_TEST} -DCORO_STRAND_DOCS=${CORO_STRAND_DOCS}
  ../cxx_coro_strand
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(cxx_coro_strand)
add_dependencies(cxx_coro_strand-depends cxx_core_chrono cxx_core_mp cxx_core_tuple fmt)
add_dependencies(cxx_depends_all cxx_coro_strand)

if(${CORO_STRAND_TEST})
  add_dependencies(cxx_coro_strand-depends googletest)
endif()


