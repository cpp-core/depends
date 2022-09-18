cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_core_codec VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_core_codec)
  return()
endif()

# Build Options
#
option(CORE_CODEC_TEST "Compile cxx_core_codec tests" ${CORE_TEST})
option(CORE_CODEC_DOCS "Generate cxx_core_codec docs" ${CORE_DOCS})

# Build and install cxx-core-util
#
ExternalProject_Add(cxx_core_codec
  PREFIX cxx_core_codec
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-codec
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORE_CODEC_TEST=${CORE_CODEC_TEST} -DCORE_CODEC_DOCS=${CORE_CODEC_DOCS}
  ../cxx_core_codec
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(cxx_core_codec)
add_dependencies(cxx_core_codec-depends cxx_core_cc libbz2 zstd)
add_dependencies(cxx_depends_all cxx_core_codec)

if(${CORE_CODEC_TEST})
  add_dependencies(cxx_core_codec-depends googletest)
endif()
