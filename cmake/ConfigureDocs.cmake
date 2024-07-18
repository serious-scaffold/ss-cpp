#[[
This file creates targets to generate documentation:

   - Doxygen: ${CMAKE_PROJECT_NAME}-doxygen: generates doxygen output.
]]

include(cmake-modules/configure/ConfigDoxygen)
configdoxygen()

if(DOXYGEN_FOUND)
  set(DOXYGEN_GENERATE_HTML
      NO
      CACHE STRING "Generate HTML output")
  set(DOXYGEN_GENERATE_XML
      YES
      CACHE STRING "Generate XML output for breathe")
  set(DOXYGEN_QUIET
      NO
      CACHE BOOL "Quiet mode")
  set(DOXYGEN_REFERENCED_BY_RELATION
      YES
      CACHE BOOL "Show referenced by relations")
  set(DOXYGEN_REFERENCES_LINK_SOURCE
      YES
      CACHE BOOL "Link to source code from references")
  set(DOXYGEN_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/docs/_build/doxygen)

  # Add XML generation doxygen target
  set(doxygen_docs ${CMAKE_PROJECT_NAME}-doxygen)
  # cmake-format: off
  doxygen_add_docs(
    ${doxygen_docs}
    "${CMAKE_BINARY_DIR}/src/compile/include"
    "${PROJECT_SOURCE_DIR}/src/compile/include"
    "${PROJECT_SOURCE_DIR}/src/exe/include"
    "${PROJECT_SOURCE_DIR}/src/header/include")
  # cmake-format: on
endif()
