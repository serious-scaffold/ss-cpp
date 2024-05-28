#[[
SPDX-License-Identifier: MIT
SPDX-FileCopyrightText: Copyright 2024 msclock
]]

# configure VCPKG_CHAINLOAD_TOOLCHAIN_FILE based on VCPKG_TARGET_TRIPLET and
# VCPKG_TARGET_ARCHITECTURE
function(_vcpkg_chainload_toolchain)
  if(DEFINED VCPKG_CHAINLOAD_TOOLCHAIN_FILE)
    return()
  endif()

  if(NOT DEFINED VCPKG_TARGET_TRIPLET OR NOT DEFINED VCPKG_TARGET_ARCHITECTURE)
    message(
      FATAL_ERROR
        "VCPKG_TARGET_TRIPLET and VCPKG_TARGET_ARCHITECTURE must be set before calling _vcpkg_chainload_toolchain()"
    )
  endif()

  # Load toolchain variables from triplet and architecture

  string(LENGTH "${VCPKG_TARGET_ARCHITECTURE}-" _prefix_len)
  string(SUBSTRING ${VCPKG_TARGET_TRIPLET} ${_prefix_len} -1 _stripped_string)
  string(REPLACE "-" ";" _triplet_parts "${_stripped_string}")
  list(GET _triplet_parts 0 _chainload_toolchain_name)

  set(_toolchain "scripts/toolchains/${_chainload_toolchain_name}.cmake")

  if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/${_toolchain}")
    set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE
        "${CMAKE_CURRENT_LIST_DIR}/${_toolchain}"
        CACHE INTERNAL "vcpkg chainload")
  elseif(EXISTS "${_VCPKG_ROOT}/${_toolchain}")
    set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE
        "${_VCPKG_ROOT}/${_toolchain}"
        CACHE INTERNAL "vcpkg chainload")
  else()
    message(
      WARNING
        "Could not find toolchain file for ${_chainload_toolchain_name}, skipping chainload"
    )
  endif()
  message(
    STATUS "vcpkg_chainload_toolchain_file: ${VCPKG_CHAINLOAD_TOOLCHAIN_FILE}")
endfunction()
