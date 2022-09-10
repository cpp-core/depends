cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
project(cxx-depends VERSION 0.1 LANGUAGES C CXX)

if(NOT TARGET cxx_googletest)
  ExternalProject_Add(cxx_googletest
    PREFIX ${DEPENDS_BUILD_DIR}/googletest
    GIT_REPOSITORY git@github.com:melton1968/googletest.git
    GIT_TAG ec44c6c1675c25b9827aacd08c02433cccde7780
    GIT_SHALLOW TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND CC=${CC} CXX=${CXX} CXXFLAGS=${CXXFLAGS} ${CMAKE_COMMAND}
    -DCMAKE_INSTALL_PREFIX=${DEPENDS_INSTALL_DIR} ../cxx_googletest
    BUILD_COMMAND make -j8
    )
  add_custom_target(cxx_googletest_install_cmake)
  add_custom_command(TARGET cxx_googletest_install_cmake POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy "${DEPENDS_SOURCE_DIR}/googletest.cmake"
    "${CMAKE_INSTALL_PREFIX}/share/cmake/googletest/googletest.cmake")
  add_dependencies(cxx_depends_all cxx_googletest)
endif()

