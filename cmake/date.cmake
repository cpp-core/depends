cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

add_library(date STATIC IMPORTED)
set_target_properties(date PROPERTIES IMPORTED_LOCATION ${DEPENDS_INSTALL_DIR}/lib/libdate-tz.a)
target_include_directories(date INTERFACE ${DEPENDS_INSTALL_DIR}/include)