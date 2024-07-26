find_package(spdlog CONFIG REQUIRED)

# The internal target will not be installed and only act as requirements for
# main and tests internally
set(target_name_internal exe_internal)

file(GLOB_RECURSE internal_srcs "src/*.cpp")
file(GLOB_RECURSE internal_hdrs "include/*.hpp")

list(FILTER internal_srcs EXCLUDE REGEX "main.cpp")

add_library(${target_name_internal} OBJECT)

generate_git_header(VERSION_NAMESPACE_PREFIX exe)

target_sources(${target_name_internal} PRIVATE ${internal_srcs}
                                               ${internal_hdrs})

target_include_interface_directories(
  ${target_name_internal} ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_CURRENT_BINARY_DIR}/git_version)

target_link_libraries(${target_name_internal} PUBLIC spdlog::spdlog)

# The main target only contains main logits. Here it is recommended to put the
# parts that need to be verified and tested in the target target_name_internal
set(target_name exe)

file(GLOB_RECURSE _srcs "src/main.cpp")

add_executable(${target_name} ${_srcs})
warn_target(${target_name})
harden_target(${target_name})
sanitize_target(${target_name})
target_code_coverage(${target_name} ALL)

target_link_libraries(${target_name} PRIVATE ${target_name_internal})

install(TARGETS ${target_name}
        RUNTIME DESTINATION $<$<CONFIG:Debug>:debug/>${CMAKE_INSTALL_BINDIR})

install_dependency(TARGETS ${target_name})

if(BUILD_TESTING)
  add_test_subdirectory(tests)
endif()
