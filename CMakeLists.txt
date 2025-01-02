cmake_minimum_required(VERSION 3.25)
message(STATUS "CMAKE VERSION:${CMAKE_VERSION}")

project(
  ss-cpp
  LANGUAGES CXX C
  HOMEPAGE_URL "https://github.com/serious-scaffold/ss-cpp"
  DESCRIPTION "A continuously evolving basic template for cpp development.")

# Project default module
find_package(cmake-modules REQUIRED)
include(cmake-modules/ProjectDefault)

# Project custom modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(ConfigureVersion)
include(ConfigureCoverage)
include(ConfigureDocs)

add_subdirectory(src)
