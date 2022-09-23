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
  PREFIX inja
  GIT_REPOSITORY https://github.com/cpp-core/inja.git
  GIT_TAG v3.3.0
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DINJA_USE_EMBEDDED_JSON=OFF
  -DBUILD_TESTING=OFF -DBUILD_BENCHMARK=OFF ../inja
  BUILD_COMMAND make -j8
  )

add_dependencies(inja json)
add_dependencies(depends_all inja)
