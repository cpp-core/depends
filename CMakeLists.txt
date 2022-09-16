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
option(CORE_TEST "Compile the tests for cxx_core* projects" ${ALL_TEST})

option(ALL_DOCS "Generate the docs for all projects" OFF)
option(CORE_DOCS "Generate the docs for cxx_core* projects" ${ALL_DOCS})

add_custom_target(cxx_depends)
add_custom_target(cxx_depends_all)

set(CC ${CMAKE_C_COMPILER})
set(CXX ${CMAKE_CXX_COMPILER})
set(CXXFLAGS -stdlib=libc++)

include(${CMAKE_SOURCE_DIR}/cmake/helpers.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/add_check_target.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/add_intermediate_targets.cmake)
include(ExternalProject)

# The collection of external packages
#
add_subdirectory(recipes/cxx_bzip2)
add_subdirectory(recipes/cxx_core_cc)
add_subdirectory(recipes/cxx_core_chrono)
add_subdirectory(recipes/cxx_core_fp)
add_subdirectory(recipes/cxx_core_mp)
add_subdirectory(recipes/cxx_core_pp)
add_subdirectory(recipes/cxx_core_string)
add_subdirectory(recipes/cxx_core_tuple)
add_subdirectory(recipes/cxx_core_util)
add_subdirectory(recipes/cxx_coro_strand)
add_subdirectory(recipes/cxx_coro_stream)
add_subdirectory(recipes/cxx_cppzmq)
add_subdirectory(recipes/cxx_cpr)
add_subdirectory(recipes/cxx_date)
add_subdirectory(recipes/cxx_fmt)
add_subdirectory(recipes/cxx_googletest)
add_subdirectory(recipes/cxx_inja)
add_subdirectory(recipes/cxx_ixwebsocket)
add_subdirectory(recipes/cxx_json)
add_subdirectory(recipes/cxx_libzmq)
add_subdirectory(recipes/cxx_ply)
add_subdirectory(recipes/cxx_spdlog)
add_subdirectory(recipes/cxx_xsimd)
add_subdirectory(recipes/cxx_xtensor)
add_subdirectory(recipes/cxx_xtl)
add_subdirectory(recipes/cxx_zstd)
