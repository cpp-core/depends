cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(stream VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET stream)
  return()
endif()

# Build Options
#
option(CORO_STREAM_TEST "Compile stream tests" ${ALL_TEST})
option(CORO_STREAM_DOCS "Generate stream docs" ${ALL_DOCS})

# Build and install cxx-core-tuple
#
ExternalProject_Add(stream
  PREFIX stream
  GIT_REPOSITORY git@github.com:melton1968/cxx-coro-stream
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORO_STREAM_TEST=${CORO_STREAM_TEST} -DCORO_STREAM_DOCS=${CORO_STREAM_DOCS}
  ../stream
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(stream)
add_dependencies(stream-depends tuple fmt)
add_dependencies(depends_all stream)

if(${CORO_STREAM_TEST})
  add_dependencies(stream-depends googletest)
endif()


