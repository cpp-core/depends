cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_bzip2 VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_bzip2)
  return()
endif()

# Build and install cxx-core-pp
#
ExternalProject_Add(cxx_bzip2
  PREFIX cxx_bzip2
  GIT_REPOSITORY git@github.com:melton1968/bzip2
  GIT_TAG master
  GIT_SHALLOW TRUE
  BUILD_IN_SOURCE TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND echo
  BUILD_COMMAND make CC=${CC} 
  INSTALL_COMMAND make install PREFIX=${CMAKE_INSTALL_PREFIX}
  )

add_library(libbz2 INTERFACE)
target_link_libraries(libbz2 INTERFACE ${CMAKE_INSTALL_PREFIX}/lib/libbz2.a)
target_include_directories(libbz2 INTERFACE ${CMAKE_INSTALL_PREFIX}/include)

install_config(libbz2)
