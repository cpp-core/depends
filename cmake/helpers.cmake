cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

function(install_config TARGET)
  install(TARGETS ${TARGET}
    EXPORT ${PROJECT_NAME}_Targets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})

  set(CONFIG_VERSION_NAME "${PROJECT_NAME}ConfigVersion.cmake")
  set(CONFIG_NAME "${PROJECT_NAME}Config.cmake")
  set(CONFIG_FILE_IN "${PROJECT_SOURCE_DIR}/cmake/${CONFIG_NAME}.in")
  set(CONFIG_FILE "${PROJECT_BINARY_DIR}/${CONFIG_NAME}")
  
  include(CMakePackageConfigHelpers)
  write_basic_package_version_file(${CONFIG_VERSION_NAME}
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion)
  
  configure_package_config_file(${CONFIG_FILE_IN} ${CONFIG_FILE}
    INSTALL_DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}/cmake)
  
  install(EXPORT ${PROJECT_NAME}_Targets
    FILE ${PROJECT_NAME}Targets.cmake
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}/cmake)

  install(FILES
    "${CONFIG_FILE}"
    "${PROJECT_BINARY_DIR}/${CONFIG_VERSION_NAME}"
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}/cmake)
endfunction()

function(configure_tests SUBDIR TARGET LIBRARIES)
  foreach(NAME ${ARGN})
    get_filename_component(DIRNAME ${NAME} DIRECTORY)
    get_filename_component(BASENAME ${NAME} NAME_WE)
    string(REPLACE / _ CATNAME ${NAME})
    
    set(TEST_NAME test_${CATNAME})
    set(TEST_FILE1 ${PROJECT_SOURCE_DIR}/test/src/${SUBDIR}/${DIRNAME}/test_${BASENAME}.cpp)
    set(TEST_FILE2 ${PROJECT_SOURCE_DIR}/test/src/${SUBDIR}/${DIRNAME}/test_${CATNAME}.cpp)
    set(TEST_FILE3 ${PROJECT_SOURCE_DIR}/test/src/${SUBDIR}/${DIRNAME}/test_${SUBDIR}_${CATNAME}.cpp)
    if(EXISTS ${TEST_FILE1})
      set(TEST_FILE ${TEST_FILE1})
    elseif(EXISTS ${TEST_FILE2})
      set(TEST_FILE ${TEST_FILE2})
    elseif(EXISTS ${TEST_FILE3})
      set(TEST_FILE ${TEST_FILE3})
    else()
      message(FATAL "Cannot find test file for ${NAME}")
    endif()
    
    list(APPEND TEST_TARGETS ${TEST_NAME})
    add_executable(${TEST_NAME} ${TEST_FILE})
    add_test(${TEST_NAME} bin/${TEST_NAME})
    target_link_libraries(${TEST_NAME} PUBLIC ${TARGET} ${LIBRARIES})
    target_include_directories(${TEST_NAME} PUBLIC ../include/core)
  endforeach(NAME)

  if (TARGET check)
    add_custom_target(check_${SUBDIR} COMMAND ${CMAKE_CTEST_COMMAND} DEPENDS ${TEST_TARGETS})
    add_dependencies(check check_${SUBDIR})
  else()
    add_custom_target(check COMMAND ${CMAKE_CTEST_COMMAND} DEPENDS ${TEST_TARGETS})
  endif()
    
endfunction()

function(configure_tests_multidir SUBDIR TARGET LIBRARIES)
  string(REPLACE / _ SUBDIR_NAME ${SUBDIR})
  foreach(NAME ${ARGN})
    get_filename_component(DIRNAME ${NAME} DIRECTORY)
    get_filename_component(BASENAME ${NAME} NAME_WE)
    set(CATNAME ${SUBDIR_NAME}_${BASENAME})
    
    set(TEST_NAME test_${CATNAME})
    set(TEST_FILE ${PROJECT_SOURCE_DIR}/test/src/${SUBDIR}/${DIRNAME}/${TEST_NAME}.cpp)

    if(NOT EXISTS ${TEST_FILE})
      set(TEST_FILE ${PROJECT_SOURCE_DIR}/test/src/${SUBDIR}/${DIRNAME}/test_${BASENAME}.cpp)
      if(NOT EXISTS ${TEST_FILE})
	message(FATAL "Cannot find test file for ${NAME} : ${TEST_FILE}")
      endif()
    endif()
    
    list(APPEND TEST_TARGETS ${TEST_NAME})
    add_executable(${TEST_NAME} ${TEST_FILE})
    add_test(${TEST_NAME} bin/${TEST_NAME})
    target_link_libraries(${TEST_NAME} PUBLIC ${TARGET} ${LIBRARIES})
    target_include_directories(${TEST_NAME} PUBLIC ../include/core)
  endforeach(NAME)

  add_custom_target(check_${SUBDIR_NAME} COMMAND ${CMAKE_CTEST_COMMAND} DEPENDS ${TEST_TARGETS})
  if (NOT TARGET check)
    add_custom_target(check COMMAND ${CMAKE_CTEST_COMMAND} DEPENDS ${TEST_TARGETS})
  endif()
endfunction()

