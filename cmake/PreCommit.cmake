# cmake-format: off
# A function to enable pre-commit to integrated with the current project.
#
# Note that this feature requires python runtime based on system.
#
# Suggested usage:
#
# ::
#
#   option(ENABLE_PRE_COMMIT "Enable pre-commit" OFF)
#   if(ENABLE_PRE_COMMIT)
#     message(STATUS "Enable pre-commit: ${ENABLE_PRE_COMMIT}")
#     include(PreCommit)
#     config_pre_commit()
#   endif()
#
# cmake-format: on
function(config_pre_commit)
  # Pre-commit hooks
  if(NOT EXISTS ${CMAKE_CURRENT_LIST_DIR}/.git/hooks/pre-commit)
    # FIND_PACKAGE(Python3 COMPONENTS Interpreter Development)
    # https://cmake.org/cmake/help/latest/policy/CMP0094.html
    if(POLICY CMP0094)
      cmake_policy(SET CMP0094 NEW) # FindPython should return the first
                                    # matching Python
    endif()
    # needed on GitHub Actions CI: actions/setup-python does not touch
    # registry/frameworks on Windows/macOS this mirrors PythonInterp behavior
    # which did not consult registry/frameworks first
    if(NOT DEFINED Python_FIND_REGISTRY)
      set(Python_FIND_REGISTRY "LAST")
    endif()
    if(NOT DEFINED Python_FIND_FRAMEWORK)
      set(Python_FIND_FRAMEWORK "LAST")
    endif()
    find_package(Python3 REQUIRED COMPONENTS Interpreter)
    message(STATUS "Python3 executable: ${Python3_EXECUTABLE}")
    execute_process(COMMAND ${Python_EXECUTABLE} -m pip install clang-format
                            nox cmake-format COMMAND_ECHO STDOUT)
    execute_process(
      COMMAND nox -k lint WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
                                            COMMAND_ECHO STDOUT)
  endif()
endfunction(config_pre_commit)
