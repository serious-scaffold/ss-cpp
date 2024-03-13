#[[
This file creates targets to generate documentation:

   - Doxygen: ${CMAKE_PROJECT_NAME}-doxygen
   - Sphinx: ${CMAKE_PROJECT_NAME}-docs
]]

include(cmake-modules/configure/ConfigDoxygen)
configdoxygen()

if(DOXYGEN_FOUND)
  # Generate XML OUTPUT for breathe
  set(DOXYGEN_GENERATE_HTML NO)
  set(DOXYGEN_GENERATE_XML YES)
  set(DOXYGEN_QUIET NO)
  set(DOXYGEN_REFERENCED_BY_RELATION YES)
  set(DOXYGEN_REFERENCES_LINK_SOURCE YES)
  set(DOXYGEN_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

  set(doxygen_docs ${CMAKE_PROJECT_NAME}-doxygen)
  doxygen_add_docs(
    ${doxygen_docs}
    "${CMAKE_BINARY_DIR}/git/include"
    "${CMAKE_BINARY_DIR}/src/compile/include"
    "${PROJECT_SOURCE_DIR}/src/compile/include"
    "${PROJECT_SOURCE_DIR}/src/executable/include"
    "${PROJECT_SOURCE_DIR}/src/header_only/include")

  if(TARGET ${doxygen_docs})
    set(Sphinx_FIND_COMPONENTS breathe)
    include(cmake-modules/configure/FindSphinx)
    unset(Sphinx_FIND_COMPONENTS)

    sphinx_add_docs(
      ${CMAKE_PROJECT_NAME}-docs
      BREATHE_PROJECTS
      ${doxygen_docs}
      BUILDER
      html
      BREATH_DEBUG
      False
      CONF_FILE
      ${PROJECT_SOURCE_DIR}/docs/conf.py
      SOURCE_DIRECTORY
      docs
      OUTPUT_DIRECTORY
      ${CMAKE_SOURCE_DIR}/docs/_build/html)
  endif()
endif()
