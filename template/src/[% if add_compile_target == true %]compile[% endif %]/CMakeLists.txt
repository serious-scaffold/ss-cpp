set(target_name compile)

# requirement for compile
find_package(proxy CONFIG REQUIRED)

file(GLOB_RECURSE _srcs "src/*.cpp")
file(GLOB_RECURSE _hdrs "include/*.hpp")

# shared library
add_library(${target_name}-shared SHARED "")
target_code_coverage(${target_name}-shared ALL)

include(GenerateExportHeader)
generate_export_header(
  ${target_name}-shared BASE_NAME "${target_name}" EXPORT_FILE_NAME
  "${CMAKE_CURRENT_BINARY_DIR}/include/${target_name}_export.hpp")

target_sources(${target_name}-shared PRIVATE ${_srcs} ${_hdrs})

target_include_interface_directories(
  ${target_name}-shared ${CMAKE_CURRENT_BINARY_DIR}/include
  ${CMAKE_CURRENT_SOURCE_DIR}/include ${CMAKE_BINARY_DIR}/git/include)

target_compile_options(
  ${target_name}-shared
  PRIVATE "$<$<CXX_COMPILER_ID:MSVC>:/source-charset:utf-8>")

target_link_libraries(
  ${target_name}-shared
  PRIVATE msft_proxy
  PRIVATE absl::log)

set_target_properties(
  ${target_name}-shared
  PROPERTIES POSITION_INDEPENDENT_CODE 1
             CXX_VISIBILITY_PRESET hidden
             VISIBILITY_INLINES_HIDDEN 1
             SOVERSION ${CMAKE_PROJECT_VERSION_MAJOR}
             OUTPUT_NAME "${target_name}"
             MACOSX_RPATH ON)

# static library
add_library(${target_name}-static STATIC "")
target_code_coverage(${target_name}-static ALL)

target_sources(${target_name}-static PRIVATE ${_srcs} ${_hdrs})

target_compile_definitions(${target_name}-static
                           INTERFACE ${target_name}_STATIC_DEFINE)

target_include_interface_directories(
  ${target_name}-static ${CMAKE_CURRENT_BINARY_DIR}/include
  ${CMAKE_CURRENT_SOURCE_DIR}/include ${CMAKE_BINARY_DIR}/git/include)

target_compile_options(
  ${target_name}-static
  PRIVATE "$<$<CXX_COMPILER_ID:MSVC>:/source-charset:utf-8>")

# Static dependencies, such as absl, do no need to export when installing
target_link_libraries(
  ${target_name}-static
  PRIVATE msft_proxy
  PRIVATE absl::log)

set_target_properties(${target_name}-static PROPERTIES ARCHIVE_OUTPUT_NAME
                                                       "${target_name}")

# msvc layout in solution
source_group("impl" REGULAR_EXPRESSION "impl/.*\\.[h|cpp]")
source_group("${target_name}" FILES "${target_name}.hpp;${target_name}.cpp")

if(CMAKE_HOST_WIN32 AND $<CXX_COMPILER_ID:MSVC>)
  install(
    FILES $<TARGET_PDB_FILE:${target_name}-shared>
    DESTINATION ${CMAKE_INSTALL_BINDIR}$<$<CONFIG:Debug>:/../debug/bin>
    OPTIONAL)
endif()

install_target(
  NAME
  ${target_name}
  TARGETS
  ${target_name}-shared
  ${target_name}-static
  VERSION
  ${CMAKE_PROJECT_VERSION}
  INCLUDES
  ${CMAKE_CURRENT_SOURCE_DIR}/include/
  ${CMAKE_CURRENT_BINARY_DIR}/include/
  ${CMAKE_BINARY_DIR}/git/include/
  LICENSE_FILE_LIST
  ${CMAKE_SOURCE_DIR}/LICENSE
  DEPENDENCIES
  msft_proxy
  absl::log)

install_dependency(TARGETS ${target_name}-shared ${target_name}-static)

# Tests
message(STATUS "BUILD_TESTING:${BUILD_TESTING}")

if(BUILD_TESTING)
  add_subdirectory(tests)
endif()
