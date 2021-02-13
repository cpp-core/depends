cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_zlib)
  ExternalProject_Add(cxx_zlib
    PREFIX ${DEPENDS_BUILD_DIR}/zlib
    GIT_REPOSITORY git@github.com:melton1968/zlib.git
    GIT_TAG cacf7f1d4e3d44d871b605da3b647f07d718623f
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_zlib
    BUILD_COMMAND make -j8
    )
endif()
