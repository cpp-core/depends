cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_ixwebsocket VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET ixwebsocket)
  return()
endif()

# Build and install data
#
ExternalProject_Add(ixwebsocket
  PREFIX cxx_ixwebsocket
  GIT_REPOSITORY git@github.com:melton1968/ixwebsocket.git
  GIT_TAG f6e34e4b34232bdfeebfe013aabd16f90f6d153d
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DUSE_TLS=1
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../ixwebsocket
  BUILD_COMMAND make -j8
  )

add_dependencies(cxx_depends_all ixwebsocket)
