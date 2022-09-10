cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_fmt)
  ExternalProject_Add(cxx_fmt
    PREFIX ${DEPENDS_BUILD_DIR}/fmt
    GIT_REPOSITORY https://github.com/melton1968/fmt
    GIT_TAG 7.1.3
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=-stdlib=libc++ ${CMAKE_COMMAND}
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR}
    -DFMT_DOC=OFF -DFMT_TEST=OFF -DFMT_FUZZ=OFF ../cxx_fmt
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_depends_all cxx_fmt)
endif()
