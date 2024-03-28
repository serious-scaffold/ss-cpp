#[[
This file creates targets to generate documentation:

   - Doxygen: ${CMAKE_PROJECT_NAME}-doxygen
   - Sphinx:
       - ${CMAKE_PROJECT_NAME}-docs: generates HTML documentation.
       - ${CMAKE_PROJECT_NAME}-docs-check: generates HTML documentation with warnings as errors.
       - ${CMAKE_PROJECT_NAME}-docs-linkcheck: checks links in HTML documentation
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
  set(DOXYGEN_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/docs/_build)

  # Add XML generation doxygen target
  set(doxygen_docs ${CMAKE_PROJECT_NAME}-doxygen)
  doxygen_add_docs(
    ${doxygen_docs}
    "${CMAKE_BINARY_DIR}/git/include"
    "${CMAKE_BINARY_DIR}/src/compile/include"
    "${PROJECT_SOURCE_DIR}/src/compile/include"
    "${PROJECT_SOURCE_DIR}/src/exe/include"
    "${PROJECT_SOURCE_DIR}/src/header/include")

  if(TARGET ${doxygen_docs})
    set(Sphinx_FIND_COMPONENTS breathe)
    include(cmake-modules/configure/FindSphinx)
    unset(Sphinx_FIND_COMPONENTS)

    set(_common_sphinx_args
        CONF_FILE
        ${PROJECT_SOURCE_DIR}/docs/conf.py
        BREATHE_PROJECTS
        ${doxygen_docs}
        BREATH_DEBUG
        False
        SOURCE_DIRECTORY
        docs)

    sphinx_add_docs(
      ${CMAKE_PROJECT_NAME}-docs
      BUILDER
      html
      EXTRA_ARGS
      -T
      OUTPUT_DIRECTORY
      ${CMAKE_SOURCE_DIR}/docs/_build/html
      ${_common_sphinx_args})

    sphinx_add_docs(
      ${CMAKE_PROJECT_NAME}-docs-check
      BUILDER
      html
      EXTRA_ARGS
      -n
      -T
      --keep-going
      -W
      OUTPUT_DIRECTORY
      ${CMAKE_SOURCE_DIR}/docs/_build/html
      ${_common_sphinx_args})

    sphinx_add_docs(
      ${CMAKE_PROJECT_NAME}-docs-linkcheck BUILDER linkcheck OUTPUT_DIRECTORY
      ${CMAKE_SOURCE_DIR}/docs/_build/linkcheck ${_common_sphinx_args})

    unset(_common_sphinx_args)
  endif()
endif()
