cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(chrono VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET chrono)
  return()
endif()

# Build Options
#
option(CHRONO_TEST "Compile chrono tests" ${ALL_TEST})
option(CHRONO_DOCS "Generate chrono docs" ${ALL_DOCS})

# Build and install cxx-core-util
#
ExternalProject_Add(chrono
  PREFIX chrono
  GIT_REPOSITORY https://github.com/cpp-core/chrono
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DCHRONO_TEST=${CHRONO_TEST} -DCHRONO_DOCS=${CHRONO_DOCS}
  ../chrono
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(chrono)
add_dependencies(chrono-depends stream string util date fmt json)
add_dependencies(depends_all chrono)

if(${CHRONO_TEST})
  add_dependencies(chrono-depends googletest)
endif()
