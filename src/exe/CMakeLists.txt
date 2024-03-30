# The private target will not be installed and only act as requirements for main
# and tests internally
set(target_name_private exe_private)

find_package(spdlog CONFIG REQUIRED)

add_library(${target_name_private} INTERFACE)

target_include_interface_directories(
  ${target_name_private} ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_BINARY_DIR}/git/include)

target_link_libraries(${target_name_private} INTERFACE spdlog::spdlog)

# The main target only contains main logits. Here it is recommended to put the
# parts that need to be verified and tested in the target target_name_private
set(target_name exe)

file(GLOB_RECURSE _srcs "src/*.cpp")

add_executable(${target_name} ${_srcs})
warn_target(${target_name})
harden_target(${target_name})
sanitize_target(${target_name})
target_code_coverage(${target_name} ALL)

target_link_libraries(${target_name} PRIVATE spdlog::spdlog
                                             ${target_name_private})

install(TARGETS ${target_name}
        RUNTIME DESTINATION $<$<CONFIG:Debug>:debug/>${CMAKE_INSTALL_BINDIR})

install_dependency(TARGETS ${target_name})

if(BUILD_TESTING)
  add_test_subdirectory(tests)
endif()
