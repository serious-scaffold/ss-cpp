#[[
SPDX-License-Identifier: MIT
SPDX-FileCopyrightText: Copyright 2024 msclock
]]

# copied from vcpkg vcpkg.cmake
function(_vcpkg_detect_host_triplet)
  if(DEFINED VCPKG_TARGET_TRIPLET)
    return()
  endif()

  if(CMAKE_GENERATOR_PLATFORM MATCHES "^[Ww][Ii][Nn]32$")
    set(_detect_target_triplet_arch x86)
  elseif(CMAKE_GENERATOR_PLATFORM MATCHES "^[Xx]64$")
    set(_detect_target_triplet_arch x64)
  elseif(CMAKE_GENERATOR_PLATFORM MATCHES "^[Aa][Rr][Mm]$")
    set(_detect_target_triplet_arch arm)
  elseif(CMAKE_GENERATOR_PLATFORM MATCHES "^[Aa][Rr][Mm]64$")
    set(_detect_target_triplet_arch arm64)
  else()
    if(CMAKE_GENERATOR STREQUAL "Visual Studio 14 2015 Win64")
      set(_detect_target_triplet_arch x64)
    elseif(CMAKE_GENERATOR STREQUAL "Visual Studio 14 2015 ARM")
      set(_detect_target_triplet_arch arm)
    elseif(CMAKE_GENERATOR STREQUAL "Visual Studio 14 2015")
      set(_detect_target_triplet_arch x86)
    elseif(CMAKE_GENERATOR STREQUAL "Visual Studio 15 2017 Win64")
      set(_detect_target_triplet_arch x64)
    elseif(CMAKE_GENERATOR STREQUAL "Visual Studio 15 2017 ARM")
      set(_detect_target_triplet_arch arm)
    elseif(CMAKE_GENERATOR STREQUAL "Visual Studio 15 2017")
      set(_detect_target_triplet_arch x86)
    elseif(CMAKE_GENERATOR STREQUAL "Visual Studio 16 2019"
           AND CMAKE_VS_PLATFORM_NAME_DEFAULT STREQUAL "ARM64")
      set(_detect_target_triplet_arch arm64)
    elseif(CMAKE_GENERATOR STREQUAL "Visual Studio 16 2019")
      set(_detect_target_triplet_arch x64)
    elseif(CMAKE_GENERATOR STREQUAL "Visual Studio 17 2022"
           AND CMAKE_VS_PLATFORM_NAME_DEFAULT STREQUAL "ARM64")
      set(_detect_target_triplet_arch arm64)
    elseif(CMAKE_GENERATOR STREQUAL "Visual Studio 17 2022")
      set(_detect_target_triplet_arch x64)
    elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin" AND DEFINED
                                                        CMAKE_OSX_ARCHITECTURES)
      list(LENGTH CMAKE_OSX_ARCHITECTURES _detect_osx_arch_count)
      if(_detect_osx_arch_count EQUAL "0")
        message(
          WARNING
            "Unable to determine target architecture from ${CMAKE_OSX_ARCHITECTURES}. "
            "Consider providing a value for the CMAKE_OSX_ARCHITECTURES cache variable. "
            "Continuing without vcpkg.")
        set(VCPKG_TOOLCHAIN ON)
        cmake_policy(POP)
        return()
      endif()

      if(_detect_osx_arch_count GREATER "1")
        message(
          WARNING
            "Detected more than one target architecture from ${CMAKE_OSX_ARCHITECTURES}. Using the first one."
        )
      endif()
      list(GET CMAKE_OSX_ARCHITECTURES "0" _detect_osx_target_arch)
      if(_detect_osx_target_arch STREQUAL "arm64")
        set(_detect_target_triplet_arch arm64)
      elseif(_detect_osx_target_arch STREQUAL "arm64s")
        set(_detect_target_triplet_arch arm64s)
      elseif(_detect_osx_target_arch STREQUAL "armv7s")
        set(_detect_target_triplet_arch armv7s)
      elseif(_detect_osx_target_arch STREQUAL "armv7")
        set(_detect_target_triplet_arch arm)
      elseif(_detect_osx_target_arch STREQUAL "x86_64")
        set(_detect_target_triplet_arch x64)
      elseif(_detect_osx_target_arch STREQUAL "i386")
        set(_detect_target_triplet_arch x86)
      else()
        message(
          WARNING
            "Unable to determine target architecture from ${CMAKE_OSX_ARCHITECTURES}, continuing without vcpkg."
        )
        set(VCPKG_TOOLCHAIN ON)
        cmake_policy(POP)
        return()
      endif()
    else()
      find_program(_vcpkg_cl cl)
      if(_vcpkg_cl MATCHES "amd64/cl.exe$" OR _vcpkg_cl MATCHES "x64/cl.exe$")
        set(_detect_target_triplet_arch x64)
      elseif(_vcpkg_cl MATCHES "arm/cl.exe$")
        set(_detect_target_triplet_arch arm)
      elseif(_vcpkg_cl MATCHES "arm64/cl.exe$")
        set(_detect_target_triplet_arch arm64)
      elseif(_vcpkg_cl MATCHES "bin/cl.exe$" OR _vcpkg_cl MATCHES "x86/cl.exe$")
        set(_detect_target_triplet_arch x86)
      elseif(
        CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "x86_64"
        OR CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "AMD64"
        OR CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "amd64")
        set(_detect_target_triplet_arch x64)
      elseif(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^i.86$")
        set(_detect_target_triplet_arch x86)
      elseif(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "s390x")
        set(_detect_target_triplet_arch s390x)
      elseif(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "ppc64le")
        set(_detect_target_triplet_arch ppc64le)
      elseif(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "armv7l")
        set(_detect_target_triplet_arch arm)
      elseif(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64|ARM64)$")
        set(_detect_target_triplet_arch arm64)
      elseif(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "riscv32")
        set(_detect_target_triplet_arch riscv32)
      elseif(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "riscv64")
        set(_detect_target_triplet_arch riscv64)
      elseif(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "loongarch32")
        set(_detect_target_triplet_arch loongarch32)
      elseif(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "loongarch64")
        set(_detect_target_triplet_arch loongarch64)
      else()
        message(
          WARNING
            "Unable to determine target architecture from ${CMAKE_HOST_SYSTEM_PROCESSOR}, continuing without vcpkg."
        )
        set(VCPKG_TOOLCHAIN ON)
        cmake_policy(POP)
        return()
      endif()
    endif()
  endif()

  # detect the target platform
  if(CMAKE_SYSTEM_NAME STREQUAL "WindowsStore" OR CMAKE_SYSTEM_NAME STREQUAL
                                                  "WindowsPhone")
    set(_detect_target_triplet_plat uwp)
  elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux"
         OR (NOT CMAKE_SYSTEM_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux"))
    set(_detect_target_triplet_plat linux)
  elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin"
         OR (NOT CMAKE_SYSTEM_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin"
            ))
    set(_detect_target_triplet_plat osx)
  elseif(CMAKE_SYSTEM_NAME STREQUAL "iOS")
    set(_detect_target_triplet_plat ios)
  elseif(MINGW)
    set(_detect_target_triplet_plat mingw-dynamic)
  elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows"
         OR (NOT CMAKE_SYSTEM_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows"
            ))
    if(XBOX_CONSOLE_TARGET STREQUAL "scarlett")
      set(_detect_target_triplet_plat xbox-scarlett)
    elseif(XBOX_CONSOLE_TARGET STREQUAL "xboxone")
      set(_detect_target_triplet_plat xbox-xboxone)
    else()
      set(_detect_target_triplet_plat windows)
    endif()
  elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD"
         OR (NOT CMAKE_SYSTEM_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "FreeBSD"
            ))
    set(_detect_target_triplet_plat freebsd)
  elseif(CMAKE_SYSTEM_NAME STREQUAL "Android"
         OR (NOT CMAKE_SYSTEM_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "Android"
            ))
    set(_detect_target_triplet_plat android)
  endif()

  if(EMSCRIPTEN)
    set(_detect_target_triplet_arch wasm32)
    set(_detect_target_triplet_plat emscripten)
  endif()

  if(NOT _detect_target_triplet_arch STREQUAL ""
     AND NOT _detect_target_triplet_plat STREQUAL "")
    set(VCPKG_DETECT_TRIPLET_ARCH
        ${_detect_target_triplet_arch}
        PARENT_SCOPE)
    set(VCPKG_DETECT_TRIPLET_PLAT
        ${_detect_target_triplet_plat}
        PARENT_SCOPE)
    set(VCPKG_HOST_TRIPLET
        "${_detect_target_triplet_arch}-${_detect_target_triplet_plat}"
        PARENT_SCOPE)
  endif()
endfunction()

# load the triplet by VCPKG_TARGET_TRIPLET
macro(_vcpkg_load_triplet)
  if(NOT DEFINED VCPKG_TARGET_TRIPLET)
    message(
      STATUS
        "VCPKG_TARGET_TRIPLET is not defined, detecting triplet from the system"
    )

    _vcpkg_detect_host_triplet()

    if(DEFINED VCPKG_HOST_TRIPLET)
      set(VCPKG_TARGET_TRIPLET "${VCPKG_HOST_TRIPLET}")
      message(STATUS "Detected triplet: ${VCPKG_TARGET_TRIPLET}")
    else()
      message(
        FATAL_ERROR
          "Unable to determine target triplet, please set it manually.")
    endif()
  endif()

  # Load triplet variables from VCPKG_TARGET_TRIPLET triplet file

  set(_triplet "triplets/${VCPKG_TARGET_TRIPLET}.cmake")
  set(_community_triplet "triplets/community/${VCPKG_TARGET_TRIPLET}.cmake")

  if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/${_triplet}")
    include("${CMAKE_CURRENT_LIST_DIR}/${_triplet}")
  elseif(EXISTS "${_VCPKG_ROOT}/${_triplet}")
    include("${_VCPKG_ROOT}/${_triplet}")
  elseif(EXISTS "${CMAKE_CURRENT_LIST_DIR}/${_community_triplet}")
    include("${CMAKE_CURRENT_LIST_DIR}/${_community_triplet}")
  elseif(EXISTS "${_VCPKG_ROOT}/${_community_triplet}")
    include("${_VCPKG_ROOT}/${_community_triplet}")
  else()
    message(
      FATAL_ERROR
        "Triplet ${VCPKG_TARGET_TRIPLET} not found at ${CMAKE_CURRENT_LIST_DIR}/${_triplet} or ${_VCPKG_ROOT}/${_triplet}"
    )
  endif()
  unset(_triplet)
  unset(_community_triplet)
endmacro(_vcpkg_load_triplet)
