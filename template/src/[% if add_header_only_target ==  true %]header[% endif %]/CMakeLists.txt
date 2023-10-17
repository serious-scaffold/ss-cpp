file(GLOB_RECURSE public_headers ${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp)

add_library(header INTERFACE)

target_include_directories(
  header INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
                   $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

target_link_libraries(header INTERFACE absl::log)

set_target_properties(header PROPERTIES PUBLIC_HEADER "${public_headers}")

install(
  TARGETS header
  EXPORT header-targets
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/header
                COMPONENT header_development)

install(
  EXPORT header-targets
  FILE header-targets.cmake
  NAMESPACE header::
  DESTINATION share/header
  COMPONENT header_development)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/header-config-version.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion)

configure_package_config_file(
  ${CMAKE_CURRENT_LIST_DIR}/header-config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/header-config.cmake
  INSTALL_DESTINATION share/header)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/header-config.cmake
              ${CMAKE_CURRENT_BINARY_DIR}/header-config-version.cmake
        DESTINATION share/header)

export(
  EXPORT header-targets
  FILE ${CMAKE_CURRENT_BINARY_DIR}/header-targets.cmake
  NAMESPACE header::)

export(PACKAGE header)

# Test
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()
