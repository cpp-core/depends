cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_uwebsockets)
  ExternalProject_Add(cxx_uwebsockets
    BUILD_IN_SOURCE 1
    PREFIX ${DEPENDS_BUILD_DIR}/uwebsockets
    GIT_REPOSITORY git@github.com:melton1968/uWebSockets.git
    GIT_TAG 0950c2a84f30c07e4cd40ea697a88800ed3609c1
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND CC=${CC} CXX=${CXX} prefix=${DEPENDS_INSTALL_DIR} WITH_OPENSSL=1 LDFLAGS=-L/opt/local/lib CFLAGS=-I/opt/local/include make
    )
  add_dependencies(cxx_depends_all cxx_uwebsockets)
endif()
