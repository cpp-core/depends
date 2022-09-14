cmake_minimum_required(VERSION 3.22 FATAL_ERROR)

function(add_intermediate_targets TARGET)
  add_custom_target(${TARGET}-depends)
  add_dependencies(${TARGET}-build ${TARGET}-depends)
  add_custom_target(${TARGET}-check
    COMMAND make check
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/recipes/${TARGET}/${TARGET}/src/${TARGET}-build)
  add_dependencies(${TARGET}-check ${TARGET}-build)
endfunction()
