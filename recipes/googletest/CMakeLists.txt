cmake_minimum_required (VERSION 3.22 FATAL_ERROR)
project (googletest VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent
#
if(TARGET cxx_googletest)
  return()
endif()

# This is the target we are building
#
add_custom_target(googletest)

include(ExternalProject)
ExternalProject_Add(cxx_googletest
  PREFIX cxx_googletest
  GIT_REPOSITORY git@github.com:melton1968/googletest.git
  GIT_TAG ec44c6c1675c25b9827aacd08c02433cccde7780
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../cxx_googletest
  BUILD_COMMAND make -j8
  )

# Config Install
#
set(GTEST_LIB ${CMAKE_INSTALL_PREFIX}/lib/libgtest.a)
set(GMOCK_LIB ${CMAKE_INSTALL_PREFIX}/lib/libgmock.a)
set(GTEST_INC ${CMAKE_INSTALL_PREFIX}/include)

add_library(cxx-googletest INTERFACE)
target_link_libraries(cxx-googletest INTERFACE ${GTEST_LIB} ${GMOCK_LIB})
target_include_directories(cxx-googletest INTERFACE ${GTEST_INC})

install_config(cxx-googletest googletest)

add_dependencies(cxx-googletest-install cxx_googletest)
add_dependencies(googletest cxx-googletest-install)
add_dependencies(depends_all googletest)
