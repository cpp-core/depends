cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cc VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cc)
  return()
endif()

# Build Options
#
option(CC_TEST "Compile cc tests" ${ALL_TEST})
option(CC_DOCS "Generate cc docs" ${ALL_DOCS})

# Build and install cxx-core-util
#
ExternalProject_Add(cc
  PREFIX cc
  GIT_REPOSITORY https://github.com/cpp-core/cc
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCC_TEST=${CC_TEST} -DCC_DOCS=${CC_DOCS}
  ../cc
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(cc)
add_dependencies(cc-depends stream util fmt json)
add_dependencies(depends_all cc)

if(${CC_TEST})
  add_dependencies(cc-depends googletest)
endif()
