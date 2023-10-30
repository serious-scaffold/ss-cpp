find_package(unofficial-sodium CONFIG REQUIRED)
find_package(infoware CONFIG REQUIRED)

# The target_name_private target will not be installed and only act as the
# requirement for main and tests internally
set(target_name_private authentication_private)

add_library(${target_name_private} INTERFACE)

target_include_interface_directories(
  ${target_name_private} ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_BINARY_DIR}/git/include)

target_link_libraries(
  ${target_name_private}
  INTERFACE absl::log unofficial-sodium::sodium
            unofficial-sodium::sodium_config_public infoware)

# The main target only contains main logits. Here it is recommended to put
# verified and testable parts to target_name_private
set(target_name authentication)

file(GLOB_RECURSE _srcs "src/*.cpp")

add_executable(${target_name} ${_srcs})
target_code_coverage(${target_name} ALL)
copy_sanitizer_runtime(${target_name})

target_link_libraries(${target_name} PRIVATE absl::log_initialize
                                             ${target_name_private})

install(
  TARGETS ${target_name}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

install_copyright(FILE_LIST ${CMAKE_SOURCE_DIR}/LICENSE DESTINATION
                  ${CMAKE_INSTALL_BINDIR})

install_dependency(TARGETS ${target_name} DIRECTORIES
                   ${RUNPATH_VCPKG_DPENDENCY_PATH})

# Test
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()
