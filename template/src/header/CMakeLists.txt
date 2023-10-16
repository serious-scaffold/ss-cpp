add_library(header INTERFACE)

target_include_directories(
  header INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
                   $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

target_link_libraries(header INTERFACE absl::log)
# Test
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()
