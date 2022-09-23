cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_depends VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_depends)
  return()
endif()

# Build Options
#
option(ALL_TEST "Compile the tests for all projects" OFF)
option(ALL_DOCS "Generate the docs for all projects" OFF)

add_custom_target(depends_all)

set(CC ${CMAKE_C_COMPILER})
set(CXX ${CMAKE_CXX_COMPILER})
set(CXXFLAGS -stdlib=libc++)

include(${CMAKE_SOURCE_DIR}/cmake/helpers.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/add_check_target.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/add_intermediate_targets.cmake)
include(ExternalProject)

# The collection of cpp-core packages.
#
add_subdirectory(recipes/cc)
add_subdirectory(recipes/chrono)
add_subdirectory(recipes/codec)
add_subdirectory(recipes/fp)
add_subdirectory(recipes/mp)
add_subdirectory(recipes/ply)
add_subdirectory(recipes/pp)
add_subdirectory(recipes/tuple)
add_subdirectory(recipes/strand)
add_subdirectory(recipes/stream)
add_subdirectory(recipes/string)
add_subdirectory(recipes/util)

# The collection of external packages
#
add_subdirectory(recipes/bzip2)
add_subdirectory(recipes/cppzmq)
add_subdirectory(recipes/cpr)
add_subdirectory(recipes/date)
add_subdirectory(recipes/fmt)
add_subdirectory(recipes/googletest)
add_subdirectory(recipes/inja)
add_subdirectory(recipes/ixwebsocket)
add_subdirectory(recipes/json)
add_subdirectory(recipes/libzmq)
add_subdirectory(recipes/spdlog)
add_subdirectory(recipes/xsimd)
add_subdirectory(recipes/xtensor)
add_subdirectory(recipes/xtl)
add_subdirectory(recipes/zstd)
