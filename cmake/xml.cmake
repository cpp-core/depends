cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

add_library(pugixml STATIC IMPORTED)
set_target_properties(pugixml PROPERTIES IMPORTED_LOCATION ${DEPENDS_INSTALL_DIR}/lib/libpugixml.a)
target_include_directories(pugixml INTERFACE ${DEPENDS_INSTALL_DIR}/include)
