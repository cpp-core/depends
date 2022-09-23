cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(pp VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent.
#
if(TARGET pp)
  return()
endif()

# Build Options
#
option(PP_TEST "Compile pp tests" ${ALL_TEST})
option(PP_DOCS "Generate pp docs" ${ALL_DOCS})

# Build and install pp
#
ExternalProject_Add(pp
  PREFIX pp
  GIT_REPOSITORY git@github.com:melton1968/cxx-core-pp
  GIT_TAG main
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  STEP_TARGETS build
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DPP_TEST=${PP_TEST} -DPP_DOCS=${PP_DOCS}
  ../pp
  BUILD_COMMAND make -j8
  )

add_intermediate_targets(pp)
add_dependencies(depends_all pp)

if(${PP_TEST})
  add_dependencies(pp-depends googletest)
endif()
