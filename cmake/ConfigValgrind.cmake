# cmake-format: off
# A macro to enable valgrind to check memcheck on testsuit
#
# Note that this macro requires enable the testing in cmake.
#
# Suggested usage:
#
# ::
#
#   # configure valgrind
#   if(CMAKE_HOST_UNIX)
#     include(ConfigValgrind)
#     config_valgrind()
#   endif()
#
# cmake-format: on
macro(config_valgrind)
  # find valgrind executable
  find_program(VALGRIND_COMMAND NAMES valgrind)
  if(VALGRIND_COMMAND)
    message(STATUS "Found valgrind directory:${VALGRIND_COMMAND}")
    set(VALGRIND_COMMAND Valgrind)
    # --gen-suppressions=all  gen suppress info automatically
    # --track-origins=yes locates the original position
    # --suppressions="${CMAKE_SOURCE_DIR}/valgrind_suppress.txt"
    set(VALGRIND_COMMAND_OPTIONS
        "--leak-check=full --track-origins=yes --show-leak-kinds=all")
  else()
    message(WARNING "Not found valgrind directory")
  endif()
endmacro()

# configure valgrind
option(ENABLE_VALGRIND "enable valgrind to check memory issues")
if(${ENABLE_VALGRIND} AND CMAKE_HOST_UNIX)
  config_valgrind()
else()
  unset(VALGRIND_COMMAND CACHE)
  unset(VALGRIND_COMMAND_OPTIONS CACHE)
endif()
