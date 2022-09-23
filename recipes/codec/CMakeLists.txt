cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(codec VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET codec)
  return()
endif()

# Build Options
#
option(CODEC_TEST "Compile codec tests" ${ALL_TEST})
option(CODEC_DOCS "Generate codec docs" ${ALL_DOCS})

# Build and install cxx-core-util
#
ExternalProject_Add(codec
  PREFIX codec
  GIT_REPOSITORY git@github.com:cpp-core/codec
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCODEC_TEST=${CODEC_TEST} -DCODEC_DOCS=${CODEC_DOCS}
  ../codec
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(codec)
add_dependencies(codec-depends cc libbz2 zstd)
add_dependencies(depends_all codec)

if(${CODEC_TEST})
  add_dependencies(codec-depends googletest)
endif()
