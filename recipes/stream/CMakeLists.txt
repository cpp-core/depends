cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(stream VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET stream)
  return()
endif()

# Build Options
#
option(STREAM_TEST "Compile stream tests" ${ALL_TEST})
option(STREAM_DOCS "Generate stream docs" ${ALL_DOCS})

# Build and install cxx-core-tuple
#
ExternalProject_Add(stream
  PREFIX stream
  GIT_REPOSITORY https://github.com/cpp-core/stream
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DSTREAM_TEST=${STREAM_TEST} -DSTREAM_DOCS=${STREAM_DOCS}
  ../stream
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(stream)
add_dependencies(stream-depends tuple fmt)
add_dependencies(depends_all stream)

if(${STREAM_TEST})
  add_dependencies(stream-depends googletest)
endif()


