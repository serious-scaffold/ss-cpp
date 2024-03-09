#[[
This file is used to configure code coverage for all targets in the project.

It supports detecting and using the following coverage tools:
  - gcov (GNU gcov)
  - llvm-cov (LLVM's llvm-cov)
  - lcov (GNU lcov)
  - opencppcoverage (OpenCppCoverage)

]]

include_guard(GLOBAL)

# cmake-format: off
include(cmake-modules/test/Coverage)
list(APPEND _excludes "${CMAKE_BINARY_DIR}" "${VCPKG_INSTALLED_DIR}")

if(UNIX)
  list(APPEND _excludes "/usr" "/usr/local" "/opt" "/opt/local")
endif()

add_code_coverage_all_targets(
  EXCLUDE_DIRS ${_excludes}
  INCLUDE_DIRS "${CMAKE_SOURCE_DIR}/src")
unset(_exclude_dirs)
unset(_excludes)

# cmake-format: on
