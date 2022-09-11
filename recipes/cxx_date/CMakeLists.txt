cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_date VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_date)
  return()
endif()

# Build and install cxx-core-pp
#
ExternalProject_Add(cxx_date
  PREFIX cxx_date
  GIT_REPOSITORY git@github.com:melton1968/date
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DUSE_SYSTEM_TZ_DB=ON
  -DBUILD_TZ_LIB=ON
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../cxx_date
  BUILD_COMMAND make -j8
  )

add_dependencies(cxx_depends_all cxx_date)
