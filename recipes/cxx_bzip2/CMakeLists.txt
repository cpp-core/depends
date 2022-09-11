cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(libbz2 VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET libbz2)
  return()
endif()

# This is the target we are building
#
add_custom_target(libbz2)

# Build and install libbz2
#
ExternalProject_Add(bzip2
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

# Config Install
#
add_library(cxx-libbz2 INTERFACE)
target_link_libraries(cxx-libbz2 INTERFACE ${CMAKE_INSTALL_PREFIX}/lib/libbz2.a)
target_include_directories(cxx-libbz2 INTERFACE ${CMAKE_INSTALL_PREFIX}/include)

install_config(cxx-libbz2 libbz2)

add_dependencies(cxx-libbz2-install bzip2)
add_dependencies(libbz2 cxx-libbz2-install)
add_dependencies(cxx_depends_all libbz2)
