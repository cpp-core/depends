cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_xtensor)
  ExternalProject_Add(cxx_xsimd
    PREFIX ${DEPENDS_BUILD_DIR}/xsimd
    GIT_REPOSITORY git@github.com:melton1968/xsimd.git
    GIT_TAG 7.6.0
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_xsimd
    BUILD_COMMAND make -j8
    )
  
  ExternalProject_Add(cxx_xtl
    PREFIX ${DEPENDS_BUILD_DIR}/xtl
    GIT_REPOSITORY git@github.com:melton1968/xtl.git
    GIT_TAG 0.7.2
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_xtl
    BUILD_COMMAND make -j8
    )
  
  ExternalProject_Add(cxx_xtensor
    PREFIX ${DEPENDS_BUILD_DIR}/xtensor
    GIT_REPOSITORY git@github.com:melton1968/xtensor.git
    GIT_TAG 0.23.10
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_xtensor
    BUILD_COMMAND make -j8
    )
  
  add_dependencies(cxx_xtensor cxx_xtl cxx_xsimd)
  add_dependencies(cxx_depends_all cxx_xtensor)
endif()
