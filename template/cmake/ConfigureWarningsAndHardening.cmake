#[[
This file configures the following things:
  - dynamic tools: sanitizers, valgrind.
  - static tools: clang-tidy, cppcheck.
  - compiler flags
  - hardening options

]]

include_guard(GLOBAL)

# ##############################################################################
# Sanitizer
# ##############################################################################

set(USE_SANITIZER
    OFF
    CACHE BOOL "Enable sanitizer")

include(cmake-modules/build/Sanitizer)

# ##############################################################################
# Valgrind
# ##############################################################################

set(USE_VALGRIND
    OFF
    CACHE BOOL "Enable Valgrind")
set(USE_VALGRIND_OPTIONS
    --leak-check=full # Each individual leak will be shown in detail.
    --show-leak-kinds=all # Show all of "definite, indirect, possible,
                          # reachable" leak kinds in the "full" report.
    --gen-suppressions=all # gen suppress info automatically.
    --track-origins=yes # Favor useful output over speed. This tracks the
                        # origins of uninitialized values, which could be very
                        # useful for memory errors. Consider turning off if
                        # Valgrind is unacceptably slow.
    CACHE STRING "valgrind options.")

include(cmake-modules/test/Valgrind)

# ##############################################################################
# Clang-Tidy
# ##############################################################################

set(USE_CLANGTIDY
    OFF
    CACHE BOOL "Enable Clang-Tidy")

include(cmake-modules/build/ClangTidy)

# ##############################################################################
# Cppcheck
# ##############################################################################

set(USE_CPPCHECK
    OFF
    CACHE BOOL "Enable Cppcheck")
set(USE_CPPCHECK_SUPPRESSION_FILE
    ${CMAKE_SOURCE_DIR}/.cppcheck-suppressions.txt
    CACHE STRING
          "Customize the path to the Cppcheck suppressions file of the project")

include(cmake-modules/build/Cppcheck)

# ##############################################################################
# CompilerFlags
# ##############################################################################

include(cmake-modules/build/CompilerFlags)

# ##############################################################################
# Hardening
# ##############################################################################

include(cmake-modules/build/Hardening)
