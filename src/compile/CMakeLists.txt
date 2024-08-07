find_package(spdlog CONFIG REQUIRED)

set(target_name compile)

file(GLOB_RECURSE _srcs "src/*.cpp")
file(GLOB_RECURSE _hdrs "include/*.hpp")

add_library(${target_name} "")
warn_target(${target_name})
harden_target(${target_name})
sanitize_target(${target_name})
target_code_coverage(${target_name} ALL)

include(GenerateExportHeader)
generate_export_header(
  ${target_name} BASE_NAME "${target_name}" EXPORT_FILE_NAME
  "${CMAKE_CURRENT_BINARY_DIR}/include/${target_name}_export.hpp")

generate_git_header(VERSION_NAMESPACE_PREFIX ${target_name})

target_sources(${target_name} PRIVATE ${_srcs} ${_hdrs})

target_include_interface_directories(
  ${target_name}
  ${CMAKE_CURRENT_BINARY_DIR}/include # for include export header
  ${CMAKE_CURRENT_SOURCE_DIR}/include # for public headers
  ${CMAKE_CURRENT_BINARY_DIR}/git_version # for git hash
)

target_link_libraries(${target_name} PRIVATE spdlog::spdlog)

set_target_properties(
  ${target_name}
  PROPERTIES POSITION_INDEPENDENT_CODE 1
             CXX_VISIBILITY_PRESET hidden
             VISIBILITY_INLINES_HIDDEN 1
             SOVERSION ${CMAKE_PROJECT_VERSION_MAJOR}
             MACOSX_RPATH ON)

if(NOT BUILD_SHARED_LIBS)
  set(static_define ${target_name}_STATIC_DEFINE)
  string(TOUPPER ${static_define} static_define)
  target_compile_definitions(${target_name} PUBLIC ${static_define})
endif()

if(BUILD_SHARED_LIBS
   AND CMAKE_HOST_WIN32
   AND $<CXX_COMPILER_ID:MSVC>)
  install(
    FILES $<TARGET_PDB_FILE:${target_name}>
    DESTINATION ${CMAKE_INSTALL_BINDIR}$<$<CONFIG:Debug>:/../debug/bin>
    OPTIONAL)
endif()

install_target(
  NAME
  ${target_name}
  TARGETS
  ${target_name}
  VERSION
  ${CMAKE_PROJECT_VERSION}
  INCLUDES
  ${CMAKE_CURRENT_SOURCE_DIR}/include/
  ${CMAKE_CURRENT_BINARY_DIR}/include/
  ${CMAKE_CURRENT_BINARY_DIR}/git_version/
  LICENSE_FILE_LIST
  ${CMAKE_SOURCE_DIR}/LICENSE
  DEPENDENCIES
  spdlog::spdlog)

install_dependency(TARGETS ${target_name})

if(BUILD_TESTING)
  add_test_subdirectory(tests)
endif()
