cmake_minimum_required (VERSION 3.22 FATAL_ERROR)
project (googletest VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent
#
if(TARGET googletest)
  return()
endif()

ExternalProject_Add(googletest
  PREFIX googletest
  GIT_REPOSITORY https://github.com/cpp-core/googletest
  GIT_TAG v1.12.0
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../googletest
  BUILD_COMMAND make -j8
  )

add_dependencies(depends_all googletest)
