include_guard(GLOBAL)

# cmake-format: off
add_code_coverage_all_targets(
  EXCLUDE
  ${VCPKG_INSTALLED_DIR}/*
  ${CMAKE_BINARY_DIR}/*
  /usr/*
  HTML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}_docs/coverage)
# cmake-format: on

if(TARGET ${CMAKE_PROJECT_NAME}_docs)
  add_dependencies(ccov-all ${CMAKE_PROJECT_NAME}_docs)
endif()
