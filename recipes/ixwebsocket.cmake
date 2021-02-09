cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_ixwebsocket)
  ExternalProject_Add(cxx_ixwebsocket
    PREFIX ${DEPENDS_BUILD_DIR}/ixwebsocket
    GIT_REPOSITORY git@github.com:melton1968/ixwebsocket.git
    GIT_TAG f6e34e4b34232bdfeebfe013aabd16f90f6d153d
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ZLIB_ROOT=${DEPENDS_INSTALL_DIR} ${CMAKE_COMMAND}
    -DUSE_TLS=1
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_ixwebsocket
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_ixwebsocket cxx_zlib)
  add_dependencies(cxx_depends_all cxx_ixwebsocket)
endif()
