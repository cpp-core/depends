cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_httpserver)
  ExternalProject_Add(cxx_libmicrohttpd
    PREFIX ${DEPENDS_BUILD_DIR}/libmicrohttpd
    GIT_REPOSITORY git@github.com:melton1968/libmicrohttpd
    GIT_TAG master
    GIT_SHALLOW TRUE
    PATCH_COMMAND git apply ${DEPENDS_PARENT_DIR}/recipes/libmicrohttpd.patch
    BUILD_IN_SOURCE TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND autoreconf -fi && ./configure CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS}
    --enable-https --with-gnutls=/opt/local --prefix=${DEPENDS_INSTALL_DIR}
    BUILD_COMMAND make -j8
    INSTALL_COMMAND make install
    )

  set(HTTP_CXXFLAGS "-I${DEPENDS_INSTALL_DIR}/include -I/opt/local/include")
  ExternalProject_Add(cxx_httpserver
    PREFIX ${DEPENDS_BUILD_DIR}/libhttpserver
    GIT_REPOSITORY git@github.com:melton1968/libhttpserver
    GIT_TAG master
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND <SOURCE_DIR>/configure LDFLAGS=-L${DEPENDS_INSTALL_DIR}/lib
    CXXFLAGS="${CXXFLAGS} ${HTTP_CXXFLAGS}" CC=${CC} CXX=${CXX} --prefix=${DEPENDS_INSTALL_DIR}
    BUILD_COMMAND make -j
    INSTALL_COMMAND make install
    )
  
  ExternalProject_Add_Step(cxx_httpserver boostrap
    COMMAND ./bootstrap
    DEPENDEES patch
    DEPENDERS configure
    WORKING_DIRECTORY <SOURCE_DIR>
    )
  
  add_dependencies(cxx_httpserver cxx_libmicrohttpd)
  #add_dependencies(cxx_depends_all cxx_httpserver)
endif()
