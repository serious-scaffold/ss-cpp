include_guard(GLOBAL)

include(cmake-modules/test/Coverage)
add_code_coverage_all_targets(
  EXCLUDE_DIRS
  "${VCPKG_INSTALLED_DIR}"
  "${CMAKE_BINARY_DIR}"
  "/usr"
  INCLUDE_DIRS "${CMAKE_SOURCE_DIR}/src")
