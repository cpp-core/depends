cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_json)
  ExternalProject_Add(cxx_json
    PREFIX ${DEPENDS_BUILD_DIR}/nlohmann_json
    GIT_REPOSITORY git@github.com:melton1968/json.git
    GIT_TAG tags/v3.7.0
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND} -DJSON_BuildTests=OFF -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_json
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_depends_all cxx_json)
endif()
