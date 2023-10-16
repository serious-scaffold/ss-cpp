file(GLOB_RECURSE api_srcs "*.cpp")
file(GLOB_RECURSE api_hdrs "*.hpp")
# Public Header
file(GLOB_RECURSE public_headers ${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp)

# shared library
add_library(api-shared SHARED "")
target_code_coverage(api-shared AUTO ALL EXCLUDE tests/*)

include(GenerateExportHeader)
generate_export_header(
  api-shared
  BASE_NAME
  "api"
  EXPORT_MACRO_NAME
  "api_EXPORT"
  EXPORT_FILE_NAME
  "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_INCLUDEDIR}/api_export.hpp"
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
  PUBLIC $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_INCLUDEDIR}>
         $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
         $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

target_compile_options(
  api-shared PRIVATE "$<$<CXX_COMPILER_ID:MSVC>:/source-charset:utf-8>")

target_link_libraries(
  api-shared
  PRIVATE msft_proxy
  PRIVATE absl::base absl::log)

set_target_properties(
  api-shared
  PROPERTIES
    POSITION_INDEPENDENT_CODE 1
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN 1
    SOVERSION ${PROJECT_VERSION_MAJOR}
    OUTPUT_NAME "api"
    PUBLIC_HEADER
    "${public_headers};${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_INCLUDEDIR}/api_export.hpp"
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
  PUBLIC $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_INCLUDEDIR}>
         $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
         $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

target_compile_options(
  api-static PRIVATE "$<$<CXX_COMPILER_ID:MSVC>:/source-charset:utf-8>")

# Static dependencies, such as absl, do no need to export when installing
target_link_libraries(
  api-static
  PRIVATE msft_proxy
  PRIVATE absl::base absl::log)

set_target_properties(
  api-static
  PROPERTIES
    POSITION_INDEPENDENT_CODE 1
    ARCHIVE_OUTPUT_NAME "api_s"
    RELEASE_POSTFIX "_s"
    PUBLIC_HEADER
    "${public_headers};${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_INCLUDEDIR}/api_export.hpp"
)

# msvc layout in solution
source_group("impl" REGULAR_EXPRESSION "impl/.*\\.[h|cpp]")
source_group("api" FILES "api.hpp;api.cpp")

if(CMAKE_HOST_WIN32 AND $<CXX_COMPILER_ID:MSVC>)
  install(
    FILES $<TARGET_PDB_FILE:api-shared>
    DESTINATION ${CMAKE_INSTALL_BINDIR}$<$<CONFIG:Debug>:/../debug/bin>
    OPTIONAL)
endif()

install(
  TARGETS api-shared
  EXPORT api-targets
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}$<$<CONFIG:Debug>:/../debug/lib>
          COMPONENT api_runtime
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}$<$<CONFIG:Debug>:/../debug/bin>
          COMPONENT api_runtime
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}$<$<CONFIG:Debug>:/../debug/lib>
          COMPONENT api_runtime
          NAMELINK_COMPONENT api_development
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/api
                COMPONENT api_development)

install(
  TARGETS api-static
  EXPORT api-targets
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}$<$<CONFIG:Debug>:/../debug/lib>
          COMPONENT api_runtime
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}$<$<CONFIG:Debug>:/../debug/bin>
          COMPONENT api_runtime
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}$<$<CONFIG:Debug>:/../debug/lib>
          COMPONENT api_runtime
          NAMELINK_COMPONENT api_development
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/api
                COMPONENT api_development)

install(
  EXPORT api-targets
  FILE api-targets.cmake
  NAMESPACE api::
  DESTINATION share/${PROJECT_NAME}
  COMPONENT api_development)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/api-config-version.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion)

configure_package_config_file(
  ${CMAKE_CURRENT_LIST_DIR}/api-config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/api-config.cmake
  INSTALL_DESTINATION share/${PROJECT_NAME})

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/api-config.cmake
              ${CMAKE_CURRENT_BINARY_DIR}/api-config-version.cmake
        DESTINATION share/${PROJECT_NAME})

# Export from build tree
export(
  EXPORT api-targets
  FILE ${CMAKE_CURRENT_BINARY_DIR}/api-targets.cmake
  NAMESPACE api::)

export(PACKAGE api)
