#[[
This file configures the compiler flags, hardening options, dynamic and static tools for the project.

]]

include_guard(GLOBAL)

# ##############################################################################
# CompilerFlags
# ##############################################################################

include(cmake-modules/build/CompilerFlags)

# ##############################################################################
# Hardening
# ##############################################################################

include(cmake-modules/build/Hardening)

# ##############################################################################
# Sanitizer
# ##############################################################################

include(cmake-modules/build/Sanitizer)

# ##############################################################################
# Valgrind
# ##############################################################################

include(cmake-modules/test/Valgrind)

# ##############################################################################
# Clang-Tidy
# ##############################################################################

include(cmake-modules/build/ClangTidy)

# ##############################################################################
# Cppcheck
# ##############################################################################

# Customize the path to the Cppcheck suppressions file of the project.
set(USE_CPPCHECK_SUPPRESSION_FILE
    ${CMAKE_SOURCE_DIR}/.cppcheck-suppressions.txt)

include(cmake-modules/build/Cppcheck)
