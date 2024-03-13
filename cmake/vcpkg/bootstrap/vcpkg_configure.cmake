#[[
SPDX-License-Identifier: MIT
SPDX-FileCopyrightText: Copyright 2023 Mikhail Svetkin
SPDX-FileCopyrightText: Copyright 2024 msclock
]]

# bootstrap and configure vcpkg
macro(vcpkg_configure)
  _vcpkg_bootstrap(${ARGN})
  _vcpkg_skip_install_on_reconfigure()
  _vcpkg_load_triplet()
  _vcpkg_chainload_toolchain()
endmacro()
