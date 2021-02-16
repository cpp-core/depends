cmake_minimum_required (VERSION 3.10 FATAL_ERROR)

add_library(cpr STATIC IMPORTED)
set_target_properties(cpr PROPERTIES IMPORTED_LOCATION ${DEPENDS_INSTALL_DIR}/lib/libcpr.so)
target_include_directories(cpr INTERFACE ${DEPENDS_INSTALL_DIR}/include)
