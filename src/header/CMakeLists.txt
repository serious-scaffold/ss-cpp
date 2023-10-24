add_library(header INTERFACE)

target_include_interface_directories(header ${CMAKE_CURRENT_SOURCE_DIR}/include
                                     ${CMAKE_BINARY_DIR}/git/include)

target_link_libraries(header INTERFACE absl::log)

install_target(
  NAME
  header
  VERSION
  ${CMAKE_PROJECT_VERSION}
  TARGETS
  header
  INCLUDES
  ${CMAKE_CURRENT_SOURCE_DIR}/include/
  ${CMAKE_BINARY_DIR}/git/include/
  DEPENDENCIES
  "absl:log")

# Test
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()
