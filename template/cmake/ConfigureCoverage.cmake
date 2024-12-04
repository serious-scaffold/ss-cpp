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
set(CODE_COVERAGE OFF CACHE BOOL "Enables code coverage.")
set(CODE_COVERAGE_GCOVR_REPORT_FORMAT xml CACHE STRING "Sets the gcovr report format.")

include(cmake-modules/test/Coverage)

# Exclude directories from code coverage
list(APPEND _excludes "${CMAKE_BINARY_DIR}")
if(VCPKG_EXPORT_MODE)
  list(APPEND _excludes "${CMAKE_SOURCE_DIR}/cmake/vcpkg/export")
endif()

# Exclude system directories from code coverage
if(NOT CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
  list(APPEND _excludes "/usr")
endif()

add_code_coverage_all_targets(
  EXCLUDE_DIRS ${_excludes}
  INCLUDE_DIRS "${CMAKE_SOURCE_DIR}/src")
unset(_exclude_dirs)
unset(_excludes)

# cmake-format: on
