cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_cpr)
  ExternalProject_Add(cxx_cpr
    PREFIX ${DEPENDS_BUILD_DIR}/cpr
    GIT_REPOSITORY https://github.com/melton1968/cpr
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
    -DCPR_FORCE_USE_SYSTEM_CURL=ON
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_cpr
    BUILD_COMMAND make -j
    )
  add_dependencies(cxx_depends_all cxx_cpr)
endif()
