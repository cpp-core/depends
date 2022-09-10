cmake_minimum_required (VERSION 3.22 FATAL_ERROR)
project (cxx_googletest VERSION 0.1 LANGUAGES C CXX)

# Make including this file idempotent
#
if(TARGET cxx_googletest)
  return()
endif()

# This is the target we are building
#
add_custom_target(cxx_googletest)

include(ExternalProject)
ExternalProject_Add(cxx_googletest_external_project
  PREFIX cxx_googletest
  GIT_REPOSITORY git@github.com:melton1968/googletest.git
  GIT_TAG ec44c6c1675c25b9827aacd08c02433cccde7780
  GIT_SHALLOW TRUE
  EXCLUDE_FROM_ALL TRUE
  CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../cxx_googletest_external_project
  BUILD_COMMAND make -j8
  )
add_dependencies(cxx_googletest cxx_googletest_external_project)

# Describe the location of the libraries and headers to used for
# client configuration.
#
set(GTEST_LIB ${CMAKE_INSTALL_PREFIX}/lib/libgtest.a)
set(GMOCK_LIB ${CMAKE_INSTALL_PREFIX}/lib/libgmock.a)
set(GTEST_INC ${CMAKE_INSTALL_PREFIX}/include)

add_library(googletest INTERFACE)
target_link_libraries(googletest INTERFACE ${GTEST_LIB} ${GMOCK_LIB})
target_include_directories(googletest INTERFACE ${GTEST_INC})

# Installation
#
include(GNUInstallDirs)

install(TARGETS googletest
  EXPORT ${PROJECT_NAME}_Targets
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})

set(CONFIG_VERSION_NAME "${PROJECT_NAME}ConfigVersion.cmake")
set(CONFIG_NAME "${PROJECT_NAME}Config.cmake")
set(CONFIG_FILE_IN "${PROJECT_SOURCE_DIR}/cmake/${CONFIG_NAME}.in")
set(CONFIG_FILE "${PROJECT_BINARY_DIR}/${CONFIG_NAME}")

message("-- cxx-core-mp: CONFIG_VERSION_NAME ${CONFIG_VERSION_NAME}")
message("-- cxx-core-mp: CONFIG_NAME ${CONFIG_NAME}")
message("-- cxx-core-mp: CONFIG_FILE ${CONFIG_FILE}")

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
