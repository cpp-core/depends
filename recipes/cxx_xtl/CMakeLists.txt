cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_xtl VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_xtl)
  return()
endif()

# Build and install cxx_xtl
#
ExternalProject_Add(cxx_xtl
  PREFIX cxx_xtl
  GIT_REPOSITORY git@github.com:melton1968/xtl.git
  GIT_TAG 0.7.2
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../cxx_xtl
  BUILD_COMMAND make -j8
  )

add_dependencies(cxx_depends_all cxx_xtl)

