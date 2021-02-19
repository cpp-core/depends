cmake_minimum_required (VERSION 3.10 FATAL_ERROR)

add_library(cpr STATIC IMPORTED)
set_target_properties(cpr
  PROPERTIES IMPORTED_LOCATION ${DEPENDS_INSTALL_DIR}/lib/libcpr${CMAKE_SHARED_LIBRARY_SUFFIX})
target_include_directories(cpr INTERFACE ${DEPENDS_INSTALL_DIR}/include)
