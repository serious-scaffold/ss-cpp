set(target_name executable)

file(GLOB_RECURSE _srcs "src/*.cpp")

add_executable(${target_name} ${_srcs})
target_code_coverage(${target_name} ALL)
copy_sanitizer_runtime(${target_name})

target_include_interface_directories(
  ${target_name} ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_BINARY_DIR}/git/include)

target_link_libraries(${target_name} PRIVATE absl::log_initialize absl::log)

install(
  TARGETS ${target_name}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

install_copyright(FILE_LIST ${CMAKE_SOURCE_DIR}/LICENSE DESTINATION
                  ${CMAKE_INSTALL_BINDIR})

install_dependency(TARGETS ${target_name} DIRECTORIES
                   ${RUNPATH_VCPKG_DPENDENCY_PATH})
