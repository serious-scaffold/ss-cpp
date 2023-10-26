# Build the target by issuing: cmake --build . --target
# ${CMAKE_PROJECT_NAME}_docs

include(cmake-modules/configure/ConfigDoxygen)
configdoxygen()

if(DOXYGEN_FOUND)

  list(APPEND CMAKE_MODULE_PATH "${cmake-modules_MODULE_PATH}/configure")
  find_package(Sphinx REQUIRED breathe)

  set(DOXYGEN_GENERATE_HTML NO)
  set(DOXYGEN_GENERATE_XML YES)
  # cmake-format:off
  doxygen_add_docs(
    ${CMAKE_PROJECT_NAME}_doxygen
    "${CMAKE_BINARY_DIR}/git/include"
    "${CMAKE_BINARY_DIR}/compile/include"
    "${PROJECT_SOURCE_DIR}/src/compile/include"
    "${PROJECT_SOURCE_DIR}/src/executable/include"
    "${PROJECT_SOURCE_DIR}/src/header_only/include"
    COMMENT "gen doxygen style docs automatically")
  # cmake-format: on

  sphinx_add_docs(
    ${CMAKE_PROJECT_NAME}_docs
    BREATHE_PROJECTS
    ${CMAKE_PROJECT_NAME}_doxygen
    BUILDER
    html
    # BREATH_DEBUG True
    CONF_FILE
    ${PROJECT_SOURCE_DIR}/docs/conf.py
    SOURCE_DIRECTORY
    docs
    OUTPUT_DIRECTORY
    ${CMAKE_PROJECT_NAME}_docs)
endif()
