cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_cppzmq VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_cppzmq)
  return()
endif()

# Build and install cxx_cppzmq
#
ExternalProject_Add(cxx_cppzmq
  PREFIX cxx_cppzmq
  GIT_REPOSITORY git@github.com:melton1968/cppzmq.git
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DCPPZMQ_BUILD_TESTS=OFF
  -DENABLE_DRAFTS=ON
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../cxx_cppzmq
  BUILD_COMMAND make -j8
  )

add_dependencies(cxx_cppzmq cxx_libzmq)
add_dependencies(cxx_depends_all cxx_cppzmq)
