cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_cppzmq)
  set(LIBZMQ_CXXFLAGS "-I${DEPENDS_INSTALL_DIR}/include -I/opt/local/include")
  ExternalProject_Add(cxx_libzmq
    PREFIX ${DEPENDS_BUILD_DIR}/libzmq
    GIT_REPOSITORY git@github.com:melton1968/libzmq.git
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} -DWITH_TLS=OFF ../cxx_libzmq
    BUILD_COMMAND make -j8
    )
  
  ExternalProject_Add(cxx_cppzmq
    PREFIX ${DEPENDS_BUILD_DIR}/cppzmq
    GIT_REPOSITORY git@github.com:melton1968/cppzmq.git
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_cppzmq
    BUILD_COMMAND make -j8
    )
  
  add_dependencies(cxx_cppzmq cxx_libzmq)
  add_dependencies(cxx_depends_all cxx_cppzmq)
endif()
