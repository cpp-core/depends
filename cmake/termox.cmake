cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

add_library(TermOx STATIC IMPORTED)
set_target_properties(TermOx PROPERTIES IMPORTED_LOCATION ${DEPENDS_INSTALL_DIR}/lib/libTermOx.a)
target_include_directories(TermOx INTERFACE ${DEPENDS_INSTALL_DIR}/include)

add_library(TermOxCurses STATIC IMPORTED)
set_target_properties(TermOxCurses PROPERTIES IMPORTED_LOCATION ${DEPENDS_INSTALL_DIR}/lib/libncursesw.a)
