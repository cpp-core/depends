cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_ranges)
  ExternalProject_Add(cxx_ranges
    PREFIX ${DEPENDS_BUILD_DIR}/ranges
    GIT_REPOSITORY git@github.com:melton1968/range-v3.git
    GIT_TAG tags/0.10.0
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
    -DCMAKE_BUILD_TYPE=Release -DRANGE_V3_DOCS=OFF -DRANGE_V3_TESTS=OFF
    -DRANGE_V3_EXAMPLES=OFF -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_ranges
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_depends_all cxx_ranges)
endif()
