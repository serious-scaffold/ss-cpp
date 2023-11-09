#[[
Vcpkg build environment

]]
if(DEFINED VCPKG_EXPORT)
  #[[
  vcpkg works with the export artifacts,see
  https://devblogs.microsoft.com/cppblog/vcpkg-2023-10-19-release-export-for-manifests-documentation-improvements-and-more/
  ]]
  if(NOT DEFINED VCPKG_TARGET_TRIPLET)
    message(FATAL_ERROR "VCPKG_TARGET_TRIPLET is not set.")
  endif()
  set(VCPKG_ROOT "${VCPKG_EXPORT}/${VCPKG_TARGET_TRIPLET}")
  if(NOT EXISTS "${VCPKG_ROOT}")
    message(
      FATAL_ERROR
        "VCPKG_EXPORT should be targeting to the output "
        "directory by `vcpkg export --raw --triplet=${VCPKG_TARGET_TRIPLET} "
        "--host-triplet=${VCPKG_TARGET_TRIPLET} --output=${VCPKG_TARGET_TRIPLET} "
        "--output-dir=${VCPKG_EXPORT}`")
  endif()
  set(VCPKG_MANIFEST_DIR "") # manually disable manifest mode
elseif(DEFINED ENV{VCPKG_ROOT})
  message(STATUS "VCPKG_ROOT:$ENV{VCPKG_ROOT}")
  set(VCPKG_ROOT "$ENV{VCPKG_ROOT}")
else()
  message(
    FATAL_ERROR "Missing VCPKG_ROOT, please check the existence of VCPKG_ROOT")
endif()

# set cmake tool chain
set(CMAKE_TOOLCHAIN_FILE ${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake)

set(VCPKG_VERBOSE
    ON
    CACHE BOOL "Vcpkg VCPKG_VERBOSE")
