cmake_minimum_required(VERSION 3.20)
message(STATUS "CMAKE VERSION:${CMAKE_VERSION}")

# Vcpkg build environment
if(DEFINED ENV{VCPKG_ROOT})
  message(STATUS "VCPKG_ROOT:$ENV{VCPKG_ROOT}")
  set(VCPKG_ROOT "$ENV{VCPKG_ROOT}")
else()
  message(
    FATAL_ERROR "Missing VCPKG_ROOT, please check the existence of VCPKG_ROOT")
endif()

# set cmake tool chain
set(CMAKE_TOOLCHAIN_FILE ${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake)

set(VCPKG_VERBOSE
    ON
    CACHE BOOL "Vcpkg VCPKG_VERBOSE")

# Project settings
project(
  cpp-scaffold
  LANGUAGES CXX C
  HOMEPAGE_URL "https://github.com/msclock/cpp-scaffold"
  DESCRIPTION "A development-focused Cpp project template.")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Source includes from vcpkg
include_directories(${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include)

# Shared cmake modules from cmake registry, see
# https://github.com/msclock/cmake-registry.
find_package(cmake-modules REQUIRED)
include(cmake-modules/configure/Default)
include(cmake-modules/configure/Common)
include(cmake-modules/configure/CheckBuildDir)
include(cmake-modules/configure/ConfigDoxygen)
include(cmake-modules/configure/FindSphinx)
include(cmake-modules/configure/UniqueOutputBinaryDir)
include(cmake-modules/build/Default)
include(cmake-modules/build/Ccache)
include(cmake-modules/build/LinkOptimization)
include(cmake-modules/test/Default)
include(cmake-modules/test/Coverage)
include(cmake-modules/test/Sanitizer)
include(cmake-modules/test/Valgrind)
include(cmake-modules/install/Common)
include(cmake-modules/install/Default)
include(cmake-modules/install/InstallDependency)
include(cmake-modules/install/Runpath)

# Print some info
show_project_version()
show_vcpkg_configuration()
show_installation()

# Add _DEBUG macro
add_debug_macro()

# LTO for release
if(${CMAKE_BUILD_TYPE} MATCHES [[Release]])
  link_time_optimization()
endif()

# Coverage
add_code_coverage_all_targets(
  HTML_OUTPUT_DIRECTORY
  ${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}_docs/coverage
  EXCLUDE
  ${VCPKG_INSTALLED_DIR}
  ${CMAKE_BINARY_DIR}/*
  /usr/include/*
  tests/*)

create_uninstall_target()

# Project custom modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(ConfigureDocs)

include(CTest)
enable_testing()
include(ConfigureGtest)

# Package dependencies using find_package
find_package(proxy CONFIG REQUIRED)
find_package(absl CONFIG REQUIRED)

add_subdirectory(src)
