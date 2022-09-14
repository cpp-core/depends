cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_core_string VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_core_string)
  return()
endif()

# Build Options
#
option(CORE_STRING_TEST "Compile cxx_core_string tests" ${CORE_TEST})
option(CORE_STRING_DOCS "Generate cxx_core_string docs" ${CORE_DOCS})

# Build and install cxx-core-util
#
ExternalProject_Add(cxx_core_string
  PREFIX cxx_core_string
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-string
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORE_STRING_TEST=${CORE_STRING_TEST} -DCORE_STRING_DOCS=${CORE_STRING_DOCS}
  ../cxx_core_string
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(cxx_core_string)
add_dependencies(cxx_core_string-depends cxx_core_util cxx_core_fp json)
add_dependencies(cxx_depends_all cxx_core_string)

if(${CORE_STRING_TEST})
  add_dependencies(cxx_core_string-depends googletest)
endif()
