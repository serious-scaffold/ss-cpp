#[[
This file detects the git commit information and sets the version number accordingly.

Detected variables:
  - CMAKE_PROJECT_GIT_COMMIT_*: git commit information (see below)
  - CMAKE_PROJECT_VERSION: version number (major.minor.patch.tweak)
  - CMAKE_PROJECT_VERSION_<MAJOR|MINOR|PATCH|TWEAK>: version numbers (as integers)

]]

include_guard(GLOBAL)
include(cmake-modules/configure/GitTools)

find_package(robotology-cmake-ycm REQUIRED)
include(robotology-cmake-ycm/modules/GitInfo)
include(robotology-cmake-ycm/modules/ExtractVersion)

# Retrieve the git commit information to CMAKE_PROJECT* variables
git_wt_info(SOURCE_DIR ${CMAKE_SOURCE_DIR} PREFIX CMAKE_PROJECT)

# Rename CMAKE_PROJECT_GIT_WT_* variables to CMAKE_PROJECT_GIT_COMMIT_*
# variables
foreach(
  _var
  DESCRIBE
  DESCRIBE_CONTAINS
  TAG
  REVISION
  TAG_REVISION
  DATE_REVISION
  AUTHOR_DATE
  AUTHOR_TIME
  AUTHOR_TZ
  AUTHOR_NAME
  AUTHOR_EMAIL
  COMMITTER_DATE
  COMMITTER_TIME
  COMMITTER_TZ
  COMMITTER_NAME
  COMMITTER_EMAIL
  HASH
  HASH_SHORT
  SUBJECT
  BODY
  DIRTY)
  set(CMAKE_PROJECT_GIT_COMMIT_${_var} "${CMAKE_PROJECT_GIT_WT_${_var}}")
endforeach()

# Set the CMAKE_PROJECT_VERSION variable
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

# Set the CMAKE_PROJECT_VERSION_<MAJOR|MINOR|PATCH|TWEAK> variables
extract_version(CMAKE_PROJECT CMAKE_PROJECT REVERSE_NAME)
