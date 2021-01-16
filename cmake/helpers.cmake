cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

function(configure_tests SUBDIR TARGET LIBRARIES)
  foreach(NAME ${ARGN})
    get_filename_component(DIRNAME ${NAME} DIRECTORY)
    get_filename_component(BASENAME ${NAME} NAME_WE)
    string(REPLACE / _ CATNAME ${NAME})
    
    set(TEST_NAME test_${CATNAME})
    set(TEST_FILE1 ${PROJECT_SOURCE_DIR}/test/src/${SUBDIR}/${DIRNAME}/test_${BASENAME}.cpp)
    set(TEST_FILE2 ${PROJECT_SOURCE_DIR}/test/src/${SUBDIR}/${DIRNAME}/test_${CATNAME}.cpp)
    if(EXISTS ${TEST_FILE1})
      set(TEST_FILE ${TEST_FILE1})
    elseif(EXISTS ${TEST_FILE2})
      set(TEST_FILE ${TEST_FILE2})
    else()
      message(FATAL "Cannot find test file for ${NAME}")
    endif()
    
    list(APPEND TEST_TARGETS ${TEST_NAME})
    add_executable(${TEST_NAME} ${TEST_FILE})
    add_test(${TEST_NAME} bin/${TEST_NAME})
    target_link_libraries(${TEST_NAME} PUBLIC ${TARGET} ${LIBRARIES})
    target_include_directories(${TEST_NAME} PUBLIC ../include/core)
  endforeach(NAME)
  
  add_custom_target(check COMMAND ${CMAKE_CTEST_COMMAND} DEPENDS ${TEST_TARGETS})
endfunction()

