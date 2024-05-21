#[[
This file configures the static analysis tool Cppcheck for the project.

It customized the suppression file for Cppcheck to ignore certain warnings and errors.
]]

include_guard(GLOBAL)

# Set the path to the Cppcheck suppressions file
set(USE_CPPCHECK_SUPPRESSION_FILE
    ${CMAKE_SOURCE_DIR}/.cppcheck-suppressions.txt)

include(cmake-modules/build/Cppcheck)
