cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

add_library(cppflow STATIC IMPORTED)
set_target_properties(cppflow PROPERTIES
  IMPORTED_LOCATION ${DEPENDS_INSTALL_DIR}/lib/libtensorflow${CMAKE_SHARED_LIBRARY_SUFFIX})
target_include_directories(cppflow INTERFACE ${DEPENDS_INSTALL_DIR}/include)
