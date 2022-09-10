cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_bzip2)
  ExternalProject_Add(cxx_bzip2
    PREFIX ${DEPENDS_BUILD_DIR}/bzip2
    GIT_REPOSITORY https://github.com/melton1968/bzip2.git
    GIT_TAG master
    GIT_SHALLOW TRUE
    BUILD_IN_SOURCE TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND echo
    BUILD_COMMAND make CC=${CC} 
    INSTALL_COMMAND make install PREFIX=${DEPENDS_INSTALL_DIR}
    )

  add_dependencies(cxx_depends_all cxx_bzip2)
endif()
