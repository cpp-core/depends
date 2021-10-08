cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_cppflow)
  ExternalProject_Add(cxx_cppflow
    PREFIX ${DEPENDS_BUILD_DIR}/cppflow
    GIT_REPOSITORY git@github.com:melton1968/cppflow
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND cp -rp ${DEPENDS_BUILD_DIR}/cppflow/src/cxx_cppflow/include/cppflow ${DEPENDS_INSTALL_DIR}/include/
    )
  add_dependencies(cxx_depends_all cxx_cppflow)
endif()
