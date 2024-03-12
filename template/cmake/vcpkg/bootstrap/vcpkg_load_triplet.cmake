#[[
SPDX-License-Identifier: MIT
SPDX-FileCopyrightText: Copyright 2024 msclock
]]

# load the triplet by VCPKG_TARGET_TRIPLET
macro(_vcpkg_load_triplet)
  if(NOT DEFINED VCPKG_TARGET_TRIPLET)
    message(
      FATAL_ERROR
        "VCPKG_TARGET_TRIPLET is not defined, please set it to the desired triplet"
    )
  endif()

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
