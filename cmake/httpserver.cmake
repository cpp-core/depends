cmake_minimum_required (VERSION 3.10 FATAL_ERROR)

add_library(libhttpserver STATIC IMPORTED)
set_target_properties(libhttpserver PROPERTIES IMPORTED_LOCATION
  ${DEPENDS_INSTALL_DIR}/lib/libhttpserver.a)
target_include_directories(libhttpserver INTERFACE ${DEPENDS_INSTALL_DIR}/include)

add_library(libmicrohttpd STATIC IMPORTED)
set_target_properties(libmicrohttpd PROPERTIES IMPORTED_LOCATION
  ${DEPENDS_INSTALL_DIR}/lib/libmicrohttpd.a)
target_include_directories(libmicrohttpd INTERFACE ${DEPENDS_INSTALL_DIR}/include)

# for TLS support
#
# add_library(gnutls SHARED IMPORTED)
# set_target_properties(gnutls PROPERTIES IMPORTED_LOCATION /opt/local/lib/libgnutls.dylib)
# target_include_directories(gnutls INTERFACE ${DEPENDS_INSTALL_DIR}/include)

# target_link_libraries(libhttpserver INTERFACE gnutls)
