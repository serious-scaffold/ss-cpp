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

# Retrieve the git commit information to CMAKE_PROJECT* variables
git_commit_info(SOURCE_DIR ${CMAKE_SOURCE_DIR} PREFIX CMAKE_PROJECT)

if(NOT CMAKE_PROJECT_GIT_COMMIT_TAG)
  set(CMAKE_PROJECT_VERSION "0.0.0.0")
else()
  set(CMAKE_PROJECT_VERSION "${CMAKE_PROJECT_GIT_COMMIT_TAG}")

  if(CMAKE_PROJECT_GIT_COMMIT_TAG_REVISION)
    set(CMAKE_PROJECT_VERSION
        "${CMAKE_PROJECT_VERSION}.${CMAKE_PROJECT_GIT_COMMIT_TAG_REVISION}")
  endif()

  string(REGEX REPLACE "^v" "" CMAKE_PROJECT_VERSION "${CMAKE_PROJECT_VERSION}")
endif()

# Set major, minor, patch and tweak version numbers
extract_version(CMAKE_PROJECT CMAKE_PROJECT REVERSE_NAME)
generate_git_header()
