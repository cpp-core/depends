cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

add_library(zlib STATIC IMPORTED)
set_target_properties(zlib PROPERTIES IMPORTED_LOCATION ${DEPENDS_INSTALL_DIR}/lib/libz.a)
target_include_directories(zlib INTERFACE ${DEPENDS_INSTALL_DIR}/include)
