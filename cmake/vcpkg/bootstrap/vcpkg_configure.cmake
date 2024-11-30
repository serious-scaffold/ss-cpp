#[[
SPDX-License-Identifier: MIT
SPDX-FileCopyrightText: Copyright 2023 Mikhail Svetkin
SPDX-FileCopyrightText: Copyright 2024 msclock
]]

function(_vcpkg_export_mode)
  if(_VCPKG_ROOT)
    _vcpkg_bootstrap(${ARGN})
    _vcpkg_skip_install_on_reconfigure()
  endif()

  set(_export_export_dir "${CMAKE_SOURCE_DIR}/cmake/vcpkg/export")
  set(_export_vcpkg_root "${_export_export_dir}/${VCPKG_TARGET_TRIPLET}")
  _vcpkg_setup_export("${_export_export_dir}" "${_export_vcpkg_root}")

  # Set vcpkg root and toolchian file variables to target the exported artifacts
  if(NOT EXISTS "${_export_vcpkg_root}")
    message(
      FATAL_ERROR
        "vcpkg export not found for triplet ${VCPKG_TARGET_TRIPLET}, check vcpkg logs for details"
    )
  endif()

  message(
    STATUS "Using vcpkg exported artifacts as vcpkg root: ${_export_vcpkg_root}"
  )

  _vcpkg_set_cache_variables("${_export_vcpkg_root}")

  # Disable vcpkg.cmake to read the cache variable to check if it should install
  # packages
  set(VCPKG_MANIFEST_DIR
      ""
      CACHE PATH "vcpkg manifest dir" FORCE)
  message(STATUS "Disable manifest mode for using vcpkg exported artifacts")
endfunction()

macro(detect_vcpkg)
  # Respect environment variable VCPKG_ROOT and VCPKG_INSTALLATION_ROOT if set
  if(DEFINED ENV{VCPKG_ROOT} AND NOT "$ENV{VCPKG_ROOT}" STREQUAL "")
    set(_VCPKG_ROOT
        "$ENV{VCPKG_ROOT}"
        CACHE PATH "Vcpkg root directory" FORCE)
  elseif(DEFINED ENV{VCPKG_INSTALLATION_ROOT}
         AND NOT "$ENV{VCPKG_INSTALLATION_ROOT}" STREQUAL "")
    set(_VCPKG_ROOT
        "$ENV{VCPKG_INSTALLATION_ROOT}"
        CACHE PATH "Vcpkg root directory" FORCE)
  else()
    unset(_VCPKG_ROOT CACHE)
  endif()
endmacro()

# bootstrap and configure vcpkg
macro(vcpkg_configure)
  detect_vcpkg()

  if(NOT VCPKG_EXPORT_MODE)
    _vcpkg_bootstrap(${ARGN})
    _vcpkg_skip_install_on_reconfigure()
  endif()

  _vcpkg_load_triplet()

  if(VCPKG_EXPORT_MODE)
    _vcpkg_export_mode(${ARGN})
  endif()

  _vcpkg_chainload_toolchain()
  message(STATUS "vcpkg_toolchain_file:$CACHE{_VCPKG_TOOLCHAIN_FILE}")
  include("$CACHE{_VCPKG_TOOLCHAIN_FILE}")
endmacro()
