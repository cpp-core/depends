cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_termox)
  ExternalProject_Add(cxx_termox
    PREFIX ${DEPENDS_BUILD_DIR}/termox
    GIT_REPOSITORY git@github.com:melton1968/termox.git
    GIT_TAG origin/main
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
    -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_termox
    BUILD_COMMAND CC=${CC} CXX=${CXX} make -j8
    )
  add_dependencies(cxx_depends_all cxx_termox)
endif()
