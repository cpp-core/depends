cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
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

set(CC ${CMAKE_C_COMPILER})
set(CXX ${CMAKE_CXX_COMPILER})
set(CXXFLAGS -stdlib=libc++)
include(ExternalProject)

add_subdirectory(cxx_core_mp)
add_subdirectory(cxx_core_pp)
add_subdirectory(cxx_googletest)

# The collection of external packages
#
# include(recipes/bigtable.cmake)
# include(recipes/bzip2.cmake)
# include(recipes/cppflow.cmake)
# include(recipes/cpr.cmake)
# include(recipes/cxx_core_pp.cmake)
# include(recipes/date.cmake)
# include(recipes/fmt.cmake)
# include(recipes/googletest.cmake)
# include(recipes/httpserver.cmake)
# include(recipes/inja.cmake)
# include(recipes/ixwebsocket.cmake)
# include(recipes/json.cmake)
# include(recipes/spdlog.cmake)
# include(recipes/termox.cmake)
# include(recipes/xml.cmake)
# include(recipes/xtensor.cmake)
# include(recipes/zmq.cmake)
# include(recipes/zstd.cmake)
