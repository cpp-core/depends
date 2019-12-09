cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

find_package(Threads REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(ZLIB REQUIRED)

if(APPLE)
   find_library(CoreFoundationFramework CoreFoundation)
endif()

set(LIBRARY_SPEC
  bigtable_client,libbigtable_client.a
  gapis_protos,libgoogleapis_cpp_bigtable_protos.a
  gapis_auth_protos,libgoogleapis_cpp_api_auth_protos.a
  gapis_operations_protos,libgoogleapis_cpp_longrunning_operations_protos.a
  gapis_policy_protos,libgoogleapis_cpp_iam_v1_iam_policy_protos.a
  gapis_client_protos,libgoogleapis_cpp_api_client_protos.a
  gapis_options_protos,libgoogleapis_cpp_iam_v1_options_protos.a
  gapis_polcity_protos,libgoogleapis_cpp_iam_v1_policy_protos.a
  gapis_annotations_protos,libgoogleapis_cpp_api_annotations_protos.a
  gapis_http_protos,libgoogleapis_cpp_api_http_protos.a
  gapis_resource_protos,libgoogleapis_cpp_api_resource_protos.a
  gapis_type_expr_protos,libgoogleapis_cpp_type_expr_protos.a
  grpc_utils,libgoogle_cloud_cpp_grpc_utils.a
  gc_common,libgoogle_cloud_cpp_common.a
  gapis_status_protos,libgoogleapis_cpp_rpc_status_protos.a
  gapis_details_protos,libgoogleapis_cpp_rpc_error_details_protos.a
  grpcpp,libgrpc++.a
  grpc,libgrpc.a
  gpr,libgpr.a
  cares,libcares.2.2.0.dylib
  address_sorting,libaddress_sorting.a
  protobuf,libprotobuf.a
  )

foreach(SPEC ${LIBRARY_SPEC})
  string(REPLACE "," ";" ARGS ${SPEC})
  list(GET ARGS 0 NAME)
  list(GET ARGS 1 FILE)
  add_library(${NAME} STATIC IMPORTED)
  set_target_properties(${NAME} PROPERTIES IMPORTED_LOCATION ${DEPENDS_INSTALL_DIR}/lib/${FILE})
  target_include_directories(${NAME} INTERFACE ${DEPENDS_INSTALL_DIR}/include)
  list(APPEND LIBRARIES ${NAME})
endforeach()

add_library(bigt_client INTERFACE)
target_link_libraries(bigt_client INTERFACE ${LIBRARIES}
  resolv
  ${CoreFoundationFramework}
  Threads::Threads
  OpenSSL::SSL
  OpenSSL::Crypto
  ZLIB::ZLIB)
