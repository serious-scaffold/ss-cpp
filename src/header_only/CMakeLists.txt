set(target_name header_only)

add_library(${target_name} INTERFACE)

target_include_interface_directories(
  ${target_name} ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_BINARY_DIR}/git/include)

target_link_libraries(${target_name} INTERFACE absl::log)

install_target(
  NAME
  ${target_name}
  VERSION
  ${CMAKE_PROJECT_VERSION}
  TARGETS
  ${target_name}
  INCLUDES
  ${CMAKE_CURRENT_SOURCE_DIR}/include/${target_name}/
  ${CMAKE_BINARY_DIR}/git/include/
  LICENSE_FILE_LIST
  ${CMAKE_SOURCE_DIR}/LICENSE
  DEPENDENCIES
  absl::log)

# Test
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()
