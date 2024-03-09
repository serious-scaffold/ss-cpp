cmake_minimum_required(VERSION 3.20)
message(STATUS "CMAKE VERSION:${CMAKE_VERSION}")

# Project settings
project(
  ss-cpp
  LANGUAGES CXX C
  HOMEPAGE_URL "https://github.com/serious-scaffold/ss-cpp"
  DESCRIPTION "A development-focused Cpp project template.")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Source includes from vcpkg
include_directories(${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include)

# Shared modules from # https://github.com/msclock/cmake-registry.
find_package(cmake-modules REQUIRED)
include(cmake-modules/configure/Default)
include(cmake-modules/configure/Common)
include(cmake-modules/configure/CheckBuildDir)
include(cmake-modules/configure/UniqueOutputBinaryDir)
include(cmake-modules/build/Default)
include(cmake-modules/build/Ccache)
include(cmake-modules/build/LinkOptimization)
include(cmake-modules/test/Default)
include(cmake-modules/test/GoogleTest)
include(cmake-modules/test/Sanitizer)
include(cmake-modules/test/Valgrind)
include(cmake-modules/install/Common)
include(cmake-modules/install/Default)
include(cmake-modules/install/InstallDependency)
include(cmake-modules/install/Runpath)

# Add _DEBUG macro
add_debug_macro()

create_uninstall_target()

# Project custom modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(ConfigureVersion)
include(ConfigureDocs)
include(ConfigureCoverage)

# Package dependencies using find_package
find_package(absl CONFIG REQUIRED)

add_subdirectory(src)

# Print project final information
show_project_version()
show_vcpkg_configuration()
show_installation()
