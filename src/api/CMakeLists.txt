file(GLOB_RECURSE api_srcs "src/*.cpp")
file(GLOB_RECURSE api_hdrs "include/*.hpp")

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
  "${CMAKE_BINARY_DIR}/include/api_export.hpp"
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

target_compile_definitions(api-shared INTERFACE $<INSTALL_INTERFACE:USING_api>)

target_include_interface_directories(
  api-shared ${CMAKE_BINARY_DIR}/include ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_BINARY_DIR}/git/include)

target_compile_options(
  api-shared PRIVATE "$<$<CXX_COMPILER_ID:MSVC>:/source-charset:utf-8>")

target_link_libraries(
  api-shared
  PRIVATE msft_proxy
  PRIVATE absl::log)

set_target_properties(
  api-shared
  PROPERTIES POSITION_INDEPENDENT_CODE 1
             CXX_VISIBILITY_PRESET hidden
             VISIBILITY_INLINES_HIDDEN 1
             SOVERSION ${CMAKE_PROJECT_VERSION_MAJOR}
             OUTPUT_NAME "api"
             MACOSX_RPATH ON)

# static library
add_library(api-static STATIC "")

target_sources(api-static PRIVATE ${api_srcs} ${api_hdrs})

target_compile_definitions(
  api-static
  PUBLIC api_STATIC_DEFINE
  INTERFACE $<INSTALL_INTERFACE:USING_api>)

target_include_interface_directories(
  api-static ${CMAKE_BINARY_DIR}/include ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_BINARY_DIR}/git/include)

target_compile_options(
  api-static PRIVATE "$<$<CXX_COMPILER_ID:MSVC>:/source-charset:utf-8>")

# Static dependencies, such as absl, do no need to export when installing
target_link_libraries(
  api-static
  PRIVATE msft_proxy
  PRIVATE absl::log)

set_target_properties(
  api-static
  PROPERTIES POSITION_INDEPENDENT_CODE 1
             ARCHIVE_OUTPUT_NAME "api_s"
             RELEASE_POSTFIX "_s")

# msvc layout in solution
source_group("impl" REGULAR_EXPRESSION "impl/.*\\.[h|cpp]")
source_group("api" FILES "api.hpp;api.cpp")

if(CMAKE_HOST_WIN32 AND $<CXX_COMPILER_ID:MSVC>)
  install(
    FILES $<TARGET_PDB_FILE:api-shared>
    DESTINATION ${CMAKE_INSTALL_BINDIR}$<$<CONFIG:Debug>:/../debug/bin>
    OPTIONAL)
endif()

install_target(
  NAME
  api
  TARGETS
  api-shared
  api-static
  VERSION
  ${CMAKE_PROJECT_VERSION}
  INCLUDES
  ${CMAKE_CURRENT_SOURCE_DIR}/include/
  ${CMAKE_BINARY_DIR}/include/
  ${CMAKE_BINARY_DIR}/git/include/
  LICENSE_FILE_LIST
  ${CMAKE_SOURCE_DIR}/LICENSE
  DEPENDENCIES
  msft_proxy
  absl::log)

# Tests
message(STATUS "BUILD_TESTING:${BUILD_TESTING}")
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()
