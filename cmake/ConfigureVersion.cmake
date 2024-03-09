#[[
This file configures the version of the project based on the git commit.

It creates a header file ${CMAKE_BINARY_DIR}/git/include with the version
information, which can be included in the project.

]]

include_guard(GLOBAL)
include(cmake-modules/configure/GitTools)

find_package(robotology-cmake-ycm REQUIRED)
include(robotology-cmake-ycm/modules/GitInfo)
include(robotology-cmake-ycm/modules/ExtractVersion)

git_commit_info(SOURCE_DIR ${CMAKE_SOURCE_DIR} PREFIX CMAKE_PROJECT)
if(NOT CMAKE_PROJECT_GIT_COMMIT_DESCRIBE)
  set(CMAKE_PROJECT_VERSION "0.0.0.0")
else()
  string(REGEX MATCH [[v?(.*)$]] matches_out
               "${CMAKE_PROJECT_GIT_COMMIT_DESCRIBE}")
  set(CMAKE_PROJECT_VERSION ${CMAKE_MATCH_1})
  string(REPLACE "-" "." CMAKE_PROJECT_VERSION ${CMAKE_PROJECT_VERSION})
endif()

extract_version(CMAKE_PROJECT CMAKE_PROJECT REVERSE_NAME)
generate_git_header()
