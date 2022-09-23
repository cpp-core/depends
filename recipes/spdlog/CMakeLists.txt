cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_spdlog VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET spdlog)
  return()
endif()

# Build and install spdlog
#
ExternalProject_Add(spdlog
  PREFIX cxx_spdlog
  GIT_REPOSITORY git@github.com:melton1968/spdlog
  GIT_TAG v1.10.0
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DSPDLOG_FMT_EXTERNAL=ON
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../spdlog
  BUILD_COMMAND make -j
  )

add_dependencies(spdlog fmt)
add_dependencies(depends_all spdlog)
