cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_date VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET date)
  return()
endif()

# Build and install data
#
ExternalProject_Add(date
  PREFIX cxx_date
  GIT_REPOSITORY https://github.com/cpp-core/date
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DUSE_SYSTEM_TZ_DB=ON
  -DBUILD_TZ_LIB=ON
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../date
  BUILD_COMMAND make -j8
  )

add_dependencies(depends_all date)
