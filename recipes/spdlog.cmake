cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_spdlog)
  ExternalProject_Add(cxx_spdlog
    PREFIX ${DEPENDS_BUILD_DIR}/spdlog
    GIT_REPOSITORY git@github.com:melton1968/spdlog
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_spdlog
    BUILD_COMMAND make -j
    )
  add_dependencies(cxx_depends_all cxx_spdlog)
endif()
