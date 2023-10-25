file(GLOB_RECURSE app_srcs "src/*.cpp")

add_executable(app ${app_srcs})
copy_sanitizer_runtime(app)

target_include_interface_directories(app ${CMAKE_CURRENT_SOURCE_DIR}/include
                                     ${CMAKE_BINARY_DIR}/git/include)

target_link_libraries(app PRIVATE absl::log_initialize absl::log)

install(
  TARGETS app
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

install_copyright(FILE_LIST ${CMAKE_SOURCE_DIR}/LICENSE DESTINATION
                  ${CMAKE_INSTALL_BINDIR})

install_dependency(TARGETS app DIRECTORIES ${RUNPATH_VCPKG_DPENDENCY_PATH})
