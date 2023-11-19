# Build the target by issuing: cmake --build . --target
# ${CMAKE_PROJECT_NAME}-docs

include(cmake-modules/configure/ConfigDoxygen)
configdoxygen()

if(DOXYGEN_FOUND)

  # Generate docs needs XML OUTPUT with sphinx
  set(DOXYGEN_GENERATE_HTML NO)
  set(DOXYGEN_GENERATE_XML YES)

  # cmake-format: off
  doxygen_add_docs(
    ${CMAKE_PROJECT_NAME}-doxygen
    "${CMAKE_BINARY_DIR}/git/include"
    "${CMAKE_BINARY_DIR}/src/compile/include"
    "${PROJECT_SOURCE_DIR}/src/compile/include"
    "${PROJECT_SOURCE_DIR}/src/executable/include"
    "${PROJECT_SOURCE_DIR}/src/header_only/include"
    COMMENT "gen doxygen style docs automatically")
  # cmake-format: on

  if(TARGET ${CMAKE_PROJECT_NAME}-doxygen)
    list(APPEND CMAKE_MODULE_PATH "${cmake-modules_MODULE_PATH}/configure")
    find_package(Sphinx REQUIRED breathe)

    sphinx_add_docs(
      ${CMAKE_PROJECT_NAME}-docs
      BREATHE_PROJECTS
      ${CMAKE_PROJECT_NAME}-doxygen
      BUILDER
      html
      BREATH_DEBUG
      False
      CONF_FILE
      ${PROJECT_SOURCE_DIR}/docs/conf.py
      SOURCE_DIRECTORY
      docs
      OUTPUT_DIRECTORY
      ${CMAKE_PROJECT_NAME}-docs)
  endif()
endif()
