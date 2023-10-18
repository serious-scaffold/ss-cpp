file(GLOB_RECURSE public_headers ${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp)

add_library(header INTERFACE)

target_include_interface_directories(header ${CMAKE_CURRENT_SOURCE_DIR}/include)

target_link_libraries(header INTERFACE absl::log)

set_target_properties(header PROPERTIES PUBLIC_HEADER "${public_headers}")

install_target(
  NAME
  header
  VERSION
  ${PROJECT_VERSION}
  TARGETS
  header
  DEPENDENCIES
  "absl:log")

# Test
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()
