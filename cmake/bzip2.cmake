cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

add_library(libbz2 STATIC IMPORTED)
set_target_properties(libbz2 PROPERTIES IMPORTED_LOCATION ${DEPENDS_INSTALL_DIR}/lib/libbz2.a)
target_include_directories(libbz2 INTERFACE ${DEPENDS_INSTALL_DIR}/include)
