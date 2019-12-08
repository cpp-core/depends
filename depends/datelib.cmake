cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

add_library(date STATIC IMPORTED)
set_target_properties(date PROPERTIES IMPORTED_LOCATION ${CORE_DEPENDS_INSTALL_DIR}/lib/libtz.a)
target_include_directories(date INTERFACE ${CORE_DEPENDS_INSTALL_DIR}/include)
