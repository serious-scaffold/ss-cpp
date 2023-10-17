file(GLOB_RECURSE app_hdrs "include/*.hpp")
file(GLOB_RECURSE app_srcs "src/*.cpp")

add_executable(app ${app_srcs} ${app_hdrs})
copy_sanitizer_runtime(app)

target_include_directories(
  app
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${CMAKE_INSTALL_INCLUDEDIR}>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

target_link_libraries(app PRIVATE absl::log_initialize absl::log)

install(
  TARGETS app
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

install_dependency(TARGETS app DIRECTORIES ${RUNPATH_VCPKG_DPENDENCY_PATH})
