#[[
SPDX-License-Identifier: MIT
SPDX-FileCopyrightText: Copyright 2024 msclock

This module initializes the build type.
]]

get_property(_is_multi_config GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)

if(_is_multi_config)
  message(STATUS "Multi-config generator detected")
  message(STATUS "Available configuration types: ${CMAKE_CONFIGURATION_TYPES}")
else()
  message(STATUS "Single-config generator detected")
  if(NOT CMAKE_BUILD_TYPE)
    message(STATUS "Setting CMAKE_BUILD_TYPE to 'Debug' as none was specified.")
    set(CMAKE_BUILD_TYPE
        Debug
        CACHE STRING "Choose the type of build.")
  endif()

  # Set the possible values of build type for cmake-gui, ccmake
  get_property(_builtin_build_types GLOBAL PROPERTY CMAKE_BUILD_TYPE)

  foreach(_type "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
    if(NOT _type IN_LIST _builtin_build_types)
      list(APPEND _builtin_build_types ${_type})
    endif()
  endforeach()

  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS ${_builtin_build_types})

  unset(_builtin_build_types)
endif()
