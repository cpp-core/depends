cmake_minimum_required(VERSION 3.15 FATAL_ERROR)
project(cxx-repo VERSION 0.1 LANGUAGES C CXX)

set(MASTER_PROJECT OFF)
if (CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
  set(MASTER_PROJECT ON)
endif()

option(REPO_TEST "Generate the tests." ${MASTER_PROJECT})
option(REPO_CORE "Build core subproject." ${MASTER_PROJECT})

if(REPO_CORE)
  add_subdirectory(./extern/cxx-core)
endif()

if(MASTER_PROJECT)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
endif()

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

add_compile_options(-Wall)
add_compile_options(-std=c++2a)
add_compile_options(-fconcepts)
add_compile_options(-O3)

set(SOURCES
  placeholder.cpp
  )

foreach(NAME ${SOURCES})
  list(APPEND FILES "src/${NAME}")
endforeach()

add_library(repo ${FILES})
target_link_libraries(repo core)
set_property(TARGET repo PROPERTY ARCHIVE_OUTPUT_DIRECTORY ../lib)

set(TOOLS
  t0)

foreach(NAME ${TOOLS})
  add_executable(${NAME} src/tools/${NAME}.cpp)
  target_link_libraries(${NAME} repo)
endforeach()

if(REPO_TEST)
  include_directories(include)
  enable_testing()
  add_subdirectory(test)
endif()
