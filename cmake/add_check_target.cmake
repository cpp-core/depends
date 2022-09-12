cmake_minimum_required(VERSION 3.22 FATAL_ERROR)

function(add_check_target TARGET)
  add_custom_target(${TARGET}_check
    COMMAND make check
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/recipes/${TARGET}/${TARGET}/src/${TARGET}-build)
  add_dependencies(${TARGET}_check ${TARGET})
endfunction()
