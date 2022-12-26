file(GLOB_RECURSE api_srcs "*.cpp")
file(GLOB_RECURSE api_hdrs "*.hpp")

set(public_headers src/api.hpp)

# shared library
add_library(api-shared SHARED "")

include(GenerateExportHeader)
generate_export_header(
  api-shared
  BASE_NAME
  "api"
  EXPORT_MACRO_NAME
  "api_EXPORT"
  EXPORT_FILE_NAME
  "${CMAKE_BINARY_DIR}/${INSTALL_INCLUDEDIR}/api_export.hpp"
  DEPRECATED_MACRO_NAME
  "api_DEPRECATED"
  NO_EXPORT_MACRO_NAME
  "api_NO_EXPORT"
  STATIC_DEFINE
  "api_STATIC_DEFINE"
  NO_DEPRECATED_MACRO_NAME
  "api_NO_DEPRECATED"
  DEFINE_NO_DEPRECATED)

target_sources(api-shared PRIVATE ${api_srcs} ${api_hdrs})

target_compile_definitions(
  api-shared
  PRIVATE PROJECT_VERSION=${PROJECT_VERSION}
  INTERFACE $<INSTALL_INTERFACE:USING_api>)

target_include_directories(
  api-shared
  PUBLIC $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/${INSTALL_INCLUDEDIR}>
         $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
         $<INSTALL_INTERFACE:${INSTALL_INCLUDEDIR}>)

target_compile_options(
  api-shared PRIVATE "$<$<CXX_COMPILER_ID:MSVC>:/source-charset:utf-8>")

target_link_libraries(api-shared PUBLIC OpenMP::OpenMP_CXX PRIVATE msft_proxy)

set_target_properties(
  api-shared
  PROPERTIES
    POSITION_INDEPENDENT_CODE 1
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN 1
    SOVERSION ${PROJECT_VERSION_MAJOR}
    OUTPUT_NAME "api"
    DEBUG_POSTFIX "_d"
    PUBLIC_HEADER
    "${public_headers};${CMAKE_BINARY_DIR}/${INSTALL_INCLUDEDIR}/api_export.hpp"
    MACOSX_RPATH ON)

# static library
add_library(api-static STATIC "")

target_sources(api-static PRIVATE ${api_srcs} ${api_hdrs})

target_compile_definitions(
  api-static
  PRIVATE PROJECT_VERSION=${PROJECT_VERSION}
  PUBLIC api_STATIC_DEFINE
  INTERFACE $<INSTALL_INTERFACE:USING_api>)

target_include_directories(
  api-static
  PUBLIC $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/${INSTALL_INCLUDEDIR}>
         $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
         $<INSTALL_INTERFACE:${INSTALL_INCLUDEDIR}>)

target_compile_options(
  api-static PRIVATE "$<$<CXX_COMPILER_ID:MSVC>:/source-charset:utf-8>")

target_link_libraries(api-static PUBLIC OpenMP::OpenMP_CXX PRIVATE msft_proxy)

set_target_properties(
  api-static
  PROPERTIES
    POSITION_INDEPENDENT_CODE 1
    ARCHIVE_OUTPUT_NAME "api"
    DEBUG_POSTFIX "_sd"
    RELEASE_POSTFIX "_s"
    PUBLIC_HEADER
    "${public_headers};${CMAKE_BINARY_DIR}/${INSTALL_INCLUDEDIR}/api_export.hpp")

# msvc layout in solution
source_group("impl" REGULAR_EXPRESSION "impl/.*\\.[h|cpp]")
source_group("api" FILES "api.hpp;api.cpp")

if(CMAKE_HOST_WIN32 AND $<CXX_COMPILER_ID:MSVC>)
  install(
    FILES $<TARGET_PDB_FILE:api-shared>
    DESTINATION ${INSTALL_BINDIR}$<$<CONFIG:Debug>:/../debug/bin>
    OPTIONAL)
endif()

install(
  TARGETS api-shared api-static
  EXPORT apiTargets
  ARCHIVE DESTINATION ${INSTALL_LIBDIR}$<$<CONFIG:Debug>:/../debug/lib>
          COMPONENT lib
  RUNTIME DESTINATION ${INSTALL_BINDIR}$<$<CONFIG:Debug>:/../debug/bin>
          COMPONENT bin
  LIBRARY DESTINATION ${INSTALL_LIBDIR}$<$<CONFIG:Debug>:/../debug/lib>
          COMPONENT lib
  PUBLIC_HEADER DESTINATION ${INSTALL_INCLUDEDIR}/api COMPONENT dev)

install(
  EXPORT apiTargets
  NAMESPACE "api::"
  DESTINATION ${INSTALL_CMAKEDIR}
  COMPONENT dev)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/apiConfigVersion.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion)

configure_package_config_file(
  ${PROJECT_SOURCE_DIR}/cmake/apiConfig.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/apiConfig.cmake
  INSTALL_DESTINATION ${INSTALL_CMAKEDIR})

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/apiConfig.cmake
              ${CMAKE_CURRENT_BINARY_DIR}/apiConfigVersion.cmake
        DESTINATION ${INSTALL_CMAKEDIR})
