# SPDX-FileCopyrightText: Copyright 2023 Mikhail Svetkin
# SPDX-License-Identifier: MIT

# bootstrap and configure vcpkg
function(vcpkg_configure)
  _vcpkg_bootstrap(${ARGN})
  _vcpkg_skip_install_on_reconfigure()
endfunction()
