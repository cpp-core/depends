cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_cpr)
  ExternalProject_Add(cxx_cpr
    PREFIX ${DEPENDS_BUILD_DIR}/cpr
    GIT_REPOSITORY git@github.com:melton1968/cpr
    GIT_TAG 41fbaca90160950f1397e0ffc6b58bd81063f131
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR}
    -DBUILD_SHARED_LIBS=OFF
    -DUSE_SYSTEM_CURL=ON ../cxx_cpr
    BUILD_COMMAND make -j
    )
  add_dependencies(cxx_depends_all cxx_cpr)
endif()
