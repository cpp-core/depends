cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_cppzmq VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cppzmq)
  return()
endif()

# Build and install cppzmq
#
ExternalProject_Add(cppzmq
  PREFIX cxx_cppzmq
  GIT_REPOSITORY git@github.com:melton1968/cppzmq.git
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DCPPZMQ_BUILD_TESTS=OFF
  -DENABLE_DRAFTS=ON
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../cppzmq
  BUILD_COMMAND make -j8
  )

add_dependencies(cppzmq libzmq)
add_dependencies(depends_all cppzmq)
