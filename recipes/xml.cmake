cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_xml)
  ExternalProject_Add(cxx_xml
    PREFIX ${DEPENDS_BUILD_DIR}/pugixml
    GIT_REPOSITORY git@github.com:melton1968/pugixml.git
    GIT_TAG tags/v1.10
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_xml
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_depends_all cxx_xml)
endif()
