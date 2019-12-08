cmake_minimum_required (VERSION 3.12 FATAL_ERROR)

add_library(nlohmann_json INTERFACE)
target_include_directories(nlohmann_json INTERFACE ${DEPENDS_INSTALL_DIR}/include)
