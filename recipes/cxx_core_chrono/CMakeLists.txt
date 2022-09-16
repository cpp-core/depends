cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(cxx_core_chrono VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET cxx_core_chrono)
  return()
endif()

# Build Options
#
option(CORE_CHRONO_TEST "Compile cxx_core_chrono tests" ${CORE_TEST})
option(CORE_CHRONO_DOCS "Generate cxx_core_chrono docs" ${CORE_DOCS})

# Build and install cxx-core-util
#
ExternalProject_Add(cxx_core_chrono
  PREFIX cxx_core_chrono
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-chrono
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCORE_CHRONO_TEST=${CORE_CHRONO_TEST} -DCORE_CHRONO_DOCS=${CORE_CHRONO_DOCS}
  ../cxx_core_chrono
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(cxx_core_chrono)
add_dependencies(cxx_core_chrono-depends cxx_coro_stream cxx_core_string cxx_core_util date fmt json)
add_dependencies(cxx_depends_all cxx_core_chrono)

if(${CORE_STRING_TEST})
  add_dependencies(cxx_core_chrono-depends googletest)
endif()
