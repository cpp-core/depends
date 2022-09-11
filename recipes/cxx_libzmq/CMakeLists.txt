cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_libzmq VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_libzmq)
  return()
endif()

# Build and install cxx_libzmq
#
set(LIBZMQ_CXXFLAGS)
ExternalProject_Add(cxx_libzmq
  PREFIX cxx_libzmq
  GIT_REPOSITORY git@github.com:melton1968/libzmq.git
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DBUILD_TESTS=OFF
  -DENABLE_DRAFTS=ON
  -DWITH_TLS=OFF
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../cxx_libzmq
  BUILD_COMMAND make -j8
  )

add_dependencies(cxx_depends_all cxx_libzmq)
