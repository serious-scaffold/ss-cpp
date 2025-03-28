#[[
To build this requires cmake specification from [cxxmodules](https://cmake.org/cmake/help/latest/manual/cmake-cxxmodules.7.html).

]]

if(WIN32 AND CMAKE_CXX_COMPILER MATCHES [[clang-cl]])
  return() # clang-cl doesn't support cxxmodules
endif()

unset(CMAKE_CXX_CLANG_TIDY)

cmake_minimum_required(VERSION 3.28.2)

set(target_name compile_module)

file(GLOB _interfaces "include/*.ixx")
file(GLOB _srcs "src/*.cpp")

add_library(${target_name})
warn_target(${target_name})
harden_target(${target_name})
sanitize_target(${target_name})
target_code_coverage(${target_name} ALL)

generate_git_header(VERSION_NAMESPACE_PREFIX ${target_name})

target_sources(
  ${target_name}
  PUBLIC FILE_SET
         cxx_modules
         TYPE
         CXX_MODULES
         FILES
         ${_interfaces}
         BASE_DIRS
         ${CMAKE_CURRENT_SOURCE_DIR}/include
  PRIVATE ${_srcs})

target_include_interface_directories(
  ${target_name} ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_CURRENT_BINARY_DIR}/git_version)

target_compile_features(${target_name} PUBLIC cxx_std_23)
set_property(TARGET ${target_name} PROPERTY CXX_SCAN_FOR_MODULES ON)

install_dependency(TARGETS ${target_name})

if(BUILD_TESTING)
  add_test_subdirectory(tests)
endif()
