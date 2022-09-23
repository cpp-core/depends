cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_bigtable)
  ExternalProject_Add(google_cloud_cpp_depend
    PREFIX ${DEPENDS_BUILD_DIR}/google_cloud_cpp_depend
    GIT_REPOSITORY git@github.com:googleapis/google-cloud-cpp.git
    GIT_TAG e98225f15cbef73a66cd199d6fe778f1abbff5ad
    PATCH_COMMAND git apply ${DEPENDS_PARENT_DIR}/patches/google-cloud-cpp-depend.patch
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
    -DGOOGLE_CLOUD_CPP_EXTERNAL_PREFIX=${DEPENDS_INSTALL_DIR}
    -DGOOGLE_CLOUD_CPP_ENABLE_MACOS_OPENSSL_CHECK=OFF ../google_cloud_cpp_depend/super
    BUILD_COMMAND CC=${CC} CXX=${CXX} make -j8 project-dependencies
    INSTALL_COMMAND ""
    )

  ExternalProject_Add(google_cloud_cpp
    PREFIX ${DEPENDS_BUILD_DIR}/google_cloud_cpp
    GIT_REPOSITORY git@github.com:googleapis/google-cloud-cpp.git
    GIT_TAG e98225f15cbef73a66cd199d6fe778f1abbff5ad
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
    -DCMAKE_PREFIX_PATH=${DEPENDS_INSTALL_DIR}
    -DGOOGLE_CLOUD_CPP_ENABLE_MACOS_OPENSSL_CHECK=OFF
    -DGOOGLE_CLOUD_CPP_ENABLE_STORAGE=OFF
    -DGOOGLE_CLOUD_CPP_ENABLE_FIRESTORE=OFF
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../google_cloud_cpp
    BUILD_COMMAND CC=${CC} CXX=${CXX} make -j8
    )

  # add_custom_target(cxx_bigtable)
  # add_dependencies(google_cloud_cpp google_cloud_cpp_depend)
  # add_dependencies(cxx_bigtable google_cloud_cpp)
  # add_dependencies(depends_all cxx_bigtable)
endif()

