cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

add_library(fmt STATIC IMPORTED)
set_target_properties(fmt PROPERTIES IMPORTED_LOCATION ${CORE_DEPENDS_INSTALL_DIR}/lib/libfmt.a)
target_include_directories(fmt INTERFACE ${CORE_DEPENDS_INSTALL_DIR}/include)
