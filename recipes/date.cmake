cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_date)
  ExternalProject_Add(cxx_date
    PREFIX ${DEPENDS_BUILD_DIR}/date
    GIT_REPOSITORY git@github.com:melton1968/date
    GIT_TAG v3.0.1
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
    -DBUILD_TZ_LIB=ON
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_date
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_depends_all cxx_date)
endif()
