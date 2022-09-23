cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_json VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET json)
  return()
endif()

# Build and install json
#
ExternalProject_Add(json
  PREFIX cxx_json
  GIT_REPOSITORY https://github.com/cpp-core/json.git
  GIT_TAG tags/v3.9.1
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DJSON_BuildTests=OFF -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../json
  BUILD_COMMAND make -j8
  )

add_dependencies(depends_all json)
