cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_zstd)
  ExternalProject_Add(cxx_zstd
    PREFIX ${DEPENDS_BUILD_DIR}/zstd
    GIT_REPOSITORY git@github.com:melton1968/zstd.git
    GIT_TAG 1c700d1d50e3b50c533ac22a5279b1936d4d70ee
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_zstd/build/cmake
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_zstd cxx_fmt)
  add_dependencies(cxx_depends_all cxx_zstd)
endif()
