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
  find_program(MEMORYCHECK_COMMAND NAMES valgrind)
  include(Dart)
  if(MEMORYCHECK_COMMAND)
    message(STATUS "Found valgrind directory:${MEMORYCHECK_COMMAND}")
    set(MEMORYCHECK_TYPE Valgrind)
    # --gen-suppressions=all  gen suppress info automatically
    # --track-origins=yes locates the original position
    set(MEMORYCHECK_COMMAND_OPTIONS
        "--leak-check=full --track-origins=yes --show-leak-kinds=all")
    # cmake-format: off
    # set(MEMORYCHECK_SUPPRESSIONS_FILE
    #     "${CMAKE_SOURCE_DIR}/valgrind_suppress.txt")
    # cmake-format: on
  else()
    message(WARNING "Not found valgrind directory")
  endif()
endmacro()

# configure valgrind
option(ENABLE_VALGRIND "enable valgrind to check memory issues")
if(ENABLE_VALGRIND AND CMAKE_HOST_UNIX)
  config_valgrind()
endif()
