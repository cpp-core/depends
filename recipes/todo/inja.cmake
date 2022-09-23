cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_inja)
  ExternalProject_Add(cxx_inja
    PREFIX ${DEPENDS_BUILD_DIR}/inja
    GIT_REPOSITORY git@github.com:melton1968/inja.git
    GIT_TAG 8e6a8428fa0d628bc58b939204ec7019e5ad1bd3
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} -DINJA_USE_EMBEDDED_JSON=OFF
    -DBUILD_TESTING=OFF -DBUILD_BENCHMARK=OFF ../cxx_inja
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_inja cxx_json)
  add_dependencies(depends_all cxx_inja)
endif()
