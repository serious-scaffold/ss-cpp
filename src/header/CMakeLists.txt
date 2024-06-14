find_package(spdlog CONFIG REQUIRED)

set(target_name header)

add_library(${target_name} INTERFACE)

generate_git_header(VERSION_NAMESPACE_PREFIX ${target_name})

target_include_interface_directories(
  ${target_name} ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_CURRENT_BINARY_DIR}/git_version)

target_link_libraries(${target_name} INTERFACE spdlog::spdlog)

install_target(
  NAME
  ${target_name}
  VERSION
  ${CMAKE_PROJECT_VERSION}
  TARGETS
  ${target_name}
  INCLUDES
  ${CMAKE_CURRENT_SOURCE_DIR}/include/${target_name}/
  ${CMAKE_CURRENT_BINARY_DIR}/git_version/
  LICENSE_FILE_LIST
  ${CMAKE_SOURCE_DIR}/LICENSE
  DEPENDENCIES
  spdlog::spdlog)

if(BUILD_TESTING)
  add_test_subdirectory(tests)
endif()
