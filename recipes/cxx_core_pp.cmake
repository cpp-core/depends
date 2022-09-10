cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_core_pp)
  ExternalProject_Add(cxx_core_pp
    PREFIX ${DEPENDS_BUILD_DIR}/cxx_core_pp
    GIT_REPOSITORY git@github.com:melton1968/cxx-core-pp
    GIT_TAG main
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR}
    -DCORE_PP_TEST=OFF -DCORE_PP_DOCS=OFF
    ../cxx_core_pp
    BUILD_COMMAND make -j8
    )
endif()
