cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_core_pp VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_core_pp)
  return()
endif()

# Build Options
#
option(CORE_PP_TEST "Compile cxx_core_pp tests" ${CORE_TEST})
option(CORE_PP_DOCS "Generate cxx_core_pp docs" ${CORE_DOCS})

# Build and install cxx_core_pp
#
ExternalProject_Add(cxx_core_pp
  PREFIX cxx_core_pp
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-pp
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORE_PP_TEST=${CORE_PP_TEST} -DCORE_PP_DOCS=${CORE_PP_DOCS}
  ../cxx_core_pp
  BUILD_COMMAND make -j8
  )

if(${CORE_PP_TEST})
  add_check_target(cxx_core_pp)
  add_dependencies(cxx_core_pp googletest)
endif()

add_dependencies(cxx_depends_all cxx_core_pp)
