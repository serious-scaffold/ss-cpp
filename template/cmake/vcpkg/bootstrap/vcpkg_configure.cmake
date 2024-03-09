#[[
SPDX-License-Identifier: MIT
SPDX-FileCopyrightText: Copyright 2023 Mikhail Svetkin
SPDX-FileCopyrightText: Copyright 2024 msclock
]]

# bootstrap and configure vcpkg
function(vcpkg_configure)
  _vcpkg_bootstrap(${ARGN})
  _vcpkg_skip_install_on_reconfigure()
endfunction()
