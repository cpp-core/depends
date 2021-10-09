cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_cppflow)

  if(CMAKE_SYSTEM_NAME STREQUAL Darwin)
    set(TF_NAME libtensorflow-cpu-darwin-x86_64-2.6.0.tar.gz)
  elseif(CMAKE_SYSTEM_NAME STREQUAL Linux)
    set(TF_NAME libtensorflow-gpu-linux-x86_64-2.6.0.tar.gz)
  endif()
  set(TF_URL https://github.com/melton1968/tensorflow_c_api/releases/download/v2.6.0/${TF_NAME})
  set(TF_FILE ${DEPENDS_BUILD_DIR}/tensorflow_c_api/src/${TF_NAME})

  ExternalProject_Add(cxx_tensorflow_c_api
    PREFIX ${DEPENDS_BUILD_DIR}/tensorflow_c_api
    DOWNLOAD_NO_EXTRACT TRUE
    DOWNLOAD_NO_PROGRESS TRUE
    URL ${TF_URL}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND gunzip -c ${TF_FILE} | tar -C ${DEPENDS_INSTALL_DIR} -xvf -
    )
  
  ExternalProject_Add(cxx_cppflow
    PREFIX ${DEPENDS_BUILD_DIR}/cppflow
    GIT_REPOSITORY git@github.com:melton1968/cppflow
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND cp -rp ${DEPENDS_BUILD_DIR}/cppflow/src/cxx_cppflow/include/cppflow ${DEPENDS_INSTALL_DIR}/include/
    )
  
  add_dependencies(cxx_cppflow cxx_tensorflow_c_api)
  add_dependencies(cxx_depends_all cxx_cppflow)
endif()
