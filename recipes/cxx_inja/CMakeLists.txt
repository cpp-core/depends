cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(inja VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET inja)
  return()
endif()

# Build and install data
#
ExternalProject_Add(inja
  PREFIX cxx_inja
  GIT_REPOSITORY git@github.com:melton1968/inja.git
  GIT_TAG 8e6a8428fa0d628bc58b939204ec7019e5ad1bd3
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DINJA_USE_EMBEDDED_JSON=OFF
  -DBUILD_TESTING=OFF -DBUILD_BENCHMARK=OFF ../inja
  BUILD_COMMAND make -j8
  )

add_dependencies(inja json)
add_dependencies(cxx_depends_all inja)
