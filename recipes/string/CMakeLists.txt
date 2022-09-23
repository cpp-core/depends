cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(string VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET string)
  return()
endif()

# Build Options
#
option(STRING_TEST "Compile string tests" ${ALL_TEST})
option(STRING_DOCS "Generate string docs" ${ALL_DOCS})

# Build and install cxx-core-util
#
ExternalProject_Add(string
  PREFIX string
  GIT_REPOSITORY git@github.com:cpp-core/string
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DSTRING_TEST=${STRING_TEST} -DSTRING_DOCS=${STRING_DOCS}
  ../string
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(string)
add_dependencies(string-depends stream fp json)
add_dependencies(depends_all string)

if(${STRING_TEST})
  add_dependencies(string-depends googletest)
endif()
