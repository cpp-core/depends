cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_coro_stream VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_coro_stream)
  return()
endif()

# Build Options
#
option(CORO_STREAM_TEST "Compile cxx_coro_stream tests" ${CORE_TEST})
option(CORO_STREAM_DOCS "Generate cxx_coro_stream docs" ${CORE_DOCS})

# Build and install cxx-core-tuple
#
ExternalProject_Add(cxx_coro_stream
  PREFIX cxx_coro_stream
  GIT_REPOSITORY git@github.com:melton1968/cxx-coro-stream
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORO_STREAM_TEST=${CORO_STREAM_TEST} -DCORO_STREAM_DOCS=${CORO_STREAM_DOCS}
  ../cxx_coro_stream
  BUILD_COMMAND make -j8
  )

if(${CORO_STREAM_TEST})
  add_check_target(cxx_coro_stream)
  add_dependencies(cxx_coro_stream-build googletest)
endif()

add_dependencies(cxx_coro_stream-build cxx_core_tuple fmt)
add_dependencies(cxx_depends_all cxx_coro_stream)
