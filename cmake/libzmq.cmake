cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

add_library(libzmq STATIC IMPORTED)
set_target_properties(libzmq PROPERTIES IMPORTED_LOCATION ${DEPENDS_INSTALL_DIR}/lib/libzmq.a)
target_include_directories(libzmq INTERFACE ${DEPENDS_INSTALL_DIR}/include)
