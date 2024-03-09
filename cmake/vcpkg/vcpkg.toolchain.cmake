# SPDX-FileCopyrightText: Copyright 2023 Mikhail Svetkin
# SPDX-License-Identifier: MIT

include_guard(GLOBAL)

cmake_minimum_required(VERSION 3.25)

get_property(IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE)

if(IN_TRY_COMPILE)
  return()
endif()

unset(IN_TRY_COMPILE)

# Vcpkg build environment
if(DEFINED ENV{VCPKG_ROOT})
  set(VCPKG_ROOT "$ENV{VCPKG_ROOT}")
  # set cmake tool chain
  file(TO_CMAKE_PATH ${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake
       vcpkg_toolchain_file)
else()
  include(${CMAKE_CURRENT_LIST_DIR}/bootstrap/vcpkg-config.cmake)

  file(READ ${CMAKE_SOURCE_DIR}/vcpkg.json _vcpkg_json)
  string(JSON _builtin_baseline GET ${_vcpkg_json} builtin-baseline)

  vcpkg_configure(
    CACHE_DIR_NAME ss-cpp REPO https://github.com/microsoft/vcpkg.git REF
    ${_builtin_baseline})
  set(vcpkg_toolchain_file $CACHE{_VCPKG_TOOLCHAIN_FILE})
endif()

set(VCPKG_VERBOSE
    ON
    CACHE BOOL "Vcpkg VCPKG_VERBOSE")

message(STATUS "vcpkg_toolchain_file:${vcpkg_toolchain_file}")
include(${vcpkg_toolchain_file})
