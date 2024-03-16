#[[
SPDX-License-Identifier: MIT
SPDX-FileCopyrightText: Copyright 2024 msclock
]]

# This function using vcpkg install and export to export vcpkg artifacts to
# ${CMAKE_SOURCE_DIR}/cmake/vcpkg/export
function(_vcpkg_setup_export export_export_dir export_vcpkg_root)
  set(_export_install_dir
      "${CMAKE_SOURCE_DIR}/out/vcpkg_installed/${VCPKG_TARGET_TRIPLET}")

  # Update exported artifacts when _VCPKG_ROOT is found
  if(DEFINED _VCPKG_ROOT AND NOT ${export_vcpkg_root} STREQUAL _VCPKG_ROOT)
    message(
      STATUS
        "Exporting vcpkg to ${export_vcpkg_root} when VCPKG_EXPORT_MODE is enabled"
    )

    if("${__vcpkg_bootstrap_host}" STREQUAL "Windows")
      set(vcpkg_cmd "$CACHE{_VCPKG_ROOT}/vcpkg.exe")
    else()
      set(vcpkg_cmd "$CACHE{_VCPKG_ROOT}/vcpkg")
    endif()

    if(NOT EXISTS ${vcpkg_cmd})
      message(
        FATAL_ERROR
          "vcpkg executable not found when export_with_manifest enabled: ${vcpkg_cmd}"
      )
    endif()

    set(_additional_args
        --vcpkg-root
        ${_VCPKG_ROOT}
        --overlay-ports
        "${VCPKG_OVERLAY_PORTS}"
        --overlay-triplets
        "${VCPKG_OVERLAY_TRIPLETS}"
        --triplet
        ${VCPKG_TARGET_TRIPLET}
        --host-triplet
        ${VCPKG_HOST_TRIPLET}
        --x-install-root
        "${_export_install_dir}")

    execute_process(
      COMMAND ${vcpkg_cmd} install --x-manifest-root ${CMAKE_SOURCE_DIR}
              ${_additional_args} ${VCPKG_INSTALL_OPTIONS}
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      RESULT_VARIABLE install_packages_result)

    if(NOT install_packages_result EQUAL 0)
      message(
        FATAL_ERROR
          "vcpkg install failed with ${install_packages_result}, check vcpkg logs for details"
      )
    endif()

    execute_process(
      COMMAND ${vcpkg_cmd} export --raw --output ${VCPKG_TARGET_TRIPLET}
              --output-dir ${export_export_dir} ${_additional_args}
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      RESULT_VARIABLE export_packages_result)

    if(NOT export_packages_result EQUAL 0)
      message(
        FATAL_ERROR
          "vcpkg export failed with ${export_packages_result}, check vcpkg logs for details"
      )
    endif()

    file(COPY "${_VCPKG_ROOT}/triplets" DESTINATION "${export_vcpkg_root}")

    file(COPY "${_VCPKG_ROOT}/scripts/toolchains"
         DESTINATION "${export_vcpkg_root}/scripts")
  endif()
endfunction()
