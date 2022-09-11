cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_cpr VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cpr)
  return()
endif()

# Build and install cpr
#
ExternalProject_Add(cpr
  PREFIX cxx_cpr
  GIT_REPOSITORY git@github.com:melton1968/cpr
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DCPR_FORCE_USE_SYSTEM_CURL=ON
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../cpr
  BUILD_COMMAND make -j 8
  )

add_dependencies(cxx_depends_all cpr)
