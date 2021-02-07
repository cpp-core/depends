cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_depends)
  # Directories
  #
  set(DEPENDS_TARGET_DIR ${CMAKE_BINARY_DIR} CACHE BOOL "Target build directory")
  option(DEPENDS_TARGET_DIR "Target build directory" ${CMAKE_BINARY_DIR})
  
  set(DEPENDS_PARENT_DIR ${PROJECT_SOURCE_DIR} CACHE INTERNAL "")
  set(DEPENDS_SOURCE_DIR ${PROJECT_SOURCE_DIR}/cmake CACHE INTERNAL "")
  set(DEPENDS_BUILD_DIR ${DEPENDS_TARGET_DIR}/${PROJECT_NAME}-build CACHE INTERNAL "")
  set(DEPENDS_INSTALL_DIR ${DEPENDS_TARGET_DIR}/${PROJECT_NAME}-install CACHE INTERNAL "")
  
  file(MAKE_DIRECTORY ${DEPENDS_INSTALL_DIR}/include)
  file(MAKE_DIRECTORY ${DEPENDS_INSTALL_DIR}/lib)
  
  list(APPEND CMAKE_PREFIX_PATH ${DEPENDS_INSTALL_DIR})
  
  add_custom_target(cxx_depends)
  add_custom_target(cxx_depends_all)
endif()

# The collection of external packages
#
set(CC ${CMAKE_C_COMPILER})
set(CXX ${CMAKE_CXX_COMPILER})
include(ExternalProject)

include(projects/bigtable.cmake)
include(projects/cpr.cmake)
include(projects/date.cmake)
include(projects/fmt.cmake)
include(projects/googletest.cmake)
include(projects/httpserver.cmake)
include(projects/inja.cmake)
include(projects/json.cmake)
include(projects/ranges.cmake)
include(projects/termox.cmake)
include(projects/xml.cmake)
include(projects/xtensor.cmake)
include(projects/zmq.cmake)
include(projects/zstd.cmake)
