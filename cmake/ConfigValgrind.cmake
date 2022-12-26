macro(config_valgrind)
  # find valgrind executable
  find_program(MEMORYCHECK_COMMAND NAMES valgrind)
  if(MEMORYCHECK_COMMAND)
    message(STATUS "Found valgrind directory:${MEMORYCHECK_COMMAND}")
    set(MEMORYCHECK_TYPE Valgrind)
    # --gen-suppressions=all  gen suppress info automatically 
    # --track-origins=yes locates the original position
    set(MEMORYCHECK_COMMAND_OPTIONS "--leak-check=full --track-origins=yes --show-leak-kinds=all")
    set(MEMORYCHECK_SUPPRESSIONS_FILE
        "${CMAKE_SOURCE_DIR}/valgrind_suppress.txt")
  else()
    message(WARNING "Not found valgrind directory")
  endif()
endmacro()
