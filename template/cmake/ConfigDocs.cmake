# Build the target by issuing: cmake --build . --target api_sphinx
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

include(ConfigDoxygen)
configdoxygen()

if(DOXYGEN_FOUND)

  find_package(Sphinx REQUIRED breathe)

  set(DOXYGEN_GENERATE_HTML NO)
  set(DOXYGEN_GENERATE_XML YES)
  doxygen_add_docs(
    api_doxygen "${CMAKE_BINARY_DIR}/include"
    "${PROJECT_SOURCE_DIR}/src/api/include"
    COMMENT "gen doxygen style docs automatically")

  sphinx_add_docs(
    api_sphinx
    BREATHE_PROJECTS
    api_doxygen
    BUILDER
    html
    # BREATH_DEBUG True
    CONF_FILE
    ${PROJECT_SOURCE_DIR}/docs/conf.py
    SOURCE_DIRECTORY
    docs)
endif()
