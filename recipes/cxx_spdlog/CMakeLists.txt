cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_spdlog VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_spdlog)
  return()
endif()

# Build and install cxx_spdlog
#
ExternalProject_Add(cxx_spdlog
  PREFIX cxx_spdlog
  GIT_REPOSITORY git@github.com:melton1968/spdlog
  GIT_TAG v1.8.2
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DSPDLOG_FMT_EXTERNAL=ON
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../cxx_spdlog
  BUILD_COMMAND make -j
  )

add_dependencies(cxx_depends_all cxx_spdlog)
