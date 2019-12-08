cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

message("-- cxx-depends: reading cmake file")

if(POLICY CMP0077)
    cmake_policy(SET CMP0077 NEW)
endif()

# Configuration variables
#
option(DEPENDS_INSTALL_DATELIB "Build and install datelib" OFF)
option(DEPENDS_INSTALL_FMTLIB "Build and install fmtlib" OFF)
option(DEPENDS_INSTALL_INJA "Build and install inja templating library" OFF)
option(DEPENDS_INSTALL_GOOGLETEST "Build and install googletest" OFF)
option(DEPENDS_INSTALL_JSON "Build and install nlohmann json library" OFF)
option(DEPENDS_INSTALL_XML "Build and install pugixml library" OFF)
option(DEPENDS_INSTALL_XTENSOR "Build and install xtensor libary" OFF)
option(DEPENDS_INSTALL_ZSTD "Build and install zstd compress library" OFF)

# Directories
#
set(DEPENDS_PARENT_DIR ${PROJECT_SOURCE_DIR} CACHE INTERNAL "")
set(DEPENDS_SOURCE_DIR ${PROJECT_SOURCE_DIR}/cmake CACHE INTERNAL "")
set(DEPENDS_BUILD_DIR ${CMAKE_BINARY_DIR}/${PROJECT_NAME}-build CACHE INTERNAL "")
set(DEPENDS_INSTALL_DIR ${CMAKE_BINARY_DIR}/${PROJECT_NAME}-install CACHE INTERNAL "")

file(MAKE_DIRECTORY ${DEPENDS_INSTALL_DIR}/include)
file(MAKE_DIRECTORY ${DEPENDS_INSTALL_DIR}/lib)

list(APPEND CMAKE_PREFIX_PATH ${DEPENDS_INSTALL_DIR})

set(CC ${CMAKE_C_COMPILER})
set(CXX ${CMAKE_CXX_COMPILER})

include(ExternalProject)
add_custom_target(cxx_depends)

if(DEPENDS_INSTALL_DATELIB)
  ExternalProject_Add(cxx_datelib
    PREFIX ${DEPENDS_BUILD_DIR}/datelib
    GIT_REPOSITORY git@github.com:melton1968/date
    GIT_TAG 92dbf3a58f9a7bc77c081f1c5a9d64cce69c5bb9
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_datelib
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_depends cxx_datelib)
endif()

if(DEPENDS_INSTALL_FMTLIB)
  ExternalProject_Add(cxx_fmtlib
    PREFIX ${DEPENDS_BUILD_DIR}/fmtlib
    GIT_REPOSITORY git@github.com:melton1968/fmt.git
    GIT_TAG 7512a55aa3ae309587ca89668ef9ec4074a51a1f
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} -DFMT_DOC=OFF -DFMT_TEST=OFF -DFMT_FUZZ=OFF ../cxx_fmtlib
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_depends cxx_fmtlib)
endif()

if(DEPENDS_INSTALL_GOOGLETEST)
  ExternalProject_Add(cxx_googletest
    PREFIX ${DEPENDS_BUILD_DIR}/googletest
    GIT_REPOSITORY git@github.com:melton1968/googletest.git
    GIT_TAG ec44c6c1675c25b9827aacd08c02433cccde7780
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_googletest
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_depends cxx_googletest)
endif()

if(DEPENDS_INSTALL_JSON OR DEPENDS_INSTALL_INJA)
  ExternalProject_Add(cxx_nlohmann_json
    PREFIX ${DEPENDS_BUILD_DIR}/nlohmann_json
    GIT_REPOSITORY git@github.com:melton1968/json.git
    GIT_TAG tags/v3.7.0
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND} -DJSON_BuildTests=OFF -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_nlohmann_json
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_depends cxx_nlohmann_json)
endif()

if(DEPENDS_INSTALL_INJA)
  ExternalProject_Add(cxx_inja
    PREFIX ${DEPENDS_BUILD_DIR}/inja
    GIT_REPOSITORY git@github.com:melton1968/inja.git
    GIT_TAG 8e6a8428fa0d628bc58b939204ec7019e5ad1bd3
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} -DINJA_USE_EMBEDDED_JSON=OFF -DBUILD_TESTING=OFF -DBUILD_BENCHMARK=OFF ../cxx_inja
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_inja cxx_nlohmann_json)
  add_dependencies(cxx_depends cxx_inja)
endif()

if(DEPENDS_INSTALL_XML)
  ExternalProject_Add(cxx_pugixml
    PREFIX ${DEPENDS_BUILD_DIR}/pugixml
    GIT_REPOSITORY git@github.com:melton1968/pugixml.git
    GIT_TAG tags/v1.10
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_pugixml
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_depends cxx_pugixml)
endif()

if(DEPENDS_INSTALL_XTENSOR)
  ExternalProject_Add(cxx_xsimd
    PREFIX ${DEPENDS_BUILD_DIR}/xsimd
    GIT_REPOSITORY git@github.com:melton1968/xsimd.git
    GIT_TAG 2e0737d85b22942dac4be2a6ba3c7d42252a5ff5
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_xsimd
    BUILD_COMMAND make -j8
    )
  
  ExternalProject_Add(cxx_xtl
    PREFIX ${DEPENDS_BUILD_DIR}/xtl
    GIT_REPOSITORY git@github.com:melton1968/xtl.git
    GIT_TAG 55ab95a45f3029e72eaa1703368e293a6fdb3d1c
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_xtl
    BUILD_COMMAND make -j8
    )
  
  ExternalProject_Add(cxx_xtensor
    PREFIX ${DEPENDS_BUILD_DIR}/xtensor
    GIT_REPOSITORY git@github.com:melton1968/xtensor.git
    GIT_TAG ef091807f7ed0e5ba7e251a6c46f4af7bba79e2e
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_xtensor
    BUILD_COMMAND make -j8
    )
  
  add_dependencies(cxx_xtensor cxx_xtl cxx_xsimd)
  add_dependencies(cxx_depends cxx_xtensor)
endif()

if(DEPENDS_INSTALL_ZSTD)
  ExternalProject_Add(cxx_zstd
    PREFIX ${DEPENDS_BUILD_DIR}/zstd
    GIT_REPOSITORY git@github.com:melton1968/zstd.git
    GIT_TAG 1c700d1d50e3b50c533ac22a5279b1936d4d70ee
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_zstd/build/cmake
    BUILD_COMMAND make -j8
    )
  add_dependencies(cxx_depends cxx_zstd)
endif()
