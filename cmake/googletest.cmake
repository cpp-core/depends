cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

add_library(gtest STATIC IMPORTED)
set_target_properties(gtest PROPERTIES IMPORTED_LOCATION ${DEPENDS_INSTALL_DIR}/lib/libgtest.a)
target_include_directories(gtest INTERFACE ${DEPENDS_INSTALL_DIR}/include)

add_library(gmock STATIC IMPORTED)
set_target_properties(gmock PROPERTIES IMPORTED_LOCATION ${DEPENDS_INSTALL_DIR}/lib/libgmock.a)
target_include_directories(gmock INTERFACE ${DEPENDS_INSTALL_DIR}/include)

add_library(googletest INTERFACE)
target_link_libraries(googletest INTERFACE gtest gmock)
