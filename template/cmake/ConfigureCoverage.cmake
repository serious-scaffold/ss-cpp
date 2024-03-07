include_guard(GLOBAL)

include(cmake-modules/test/Coverage)

# cmake-format: off
add_code_coverage_all_targets(
  EXCLUDE
  ${VCPKG_INSTALLED_DIR}/*
  ${CMAKE_BINARY_DIR}/*
  /usr/*
  HTML_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/docs/_build/coverage)
# cmake-format: on
