#[=======================================================================[.rst:
Check if the current directory is a source directory or a build directory.

.. note::
    The configuration must be set after project().

If the current directory is a source directory, display an error message and terminate the build process.
If the current directory is a build directory, display a status message indicating that the build directory check passed.

Example Usage:
```cmake
include(CheckBuildDirectory)
```

Outputs:
- If the current directory is a source directory, a fatal error message is displayed.
- If the current directory is a build directory, a status message is displayed.
#]=======================================================================]

file(TO_CMAKE_PATH "${PROJECT_BINARY_DIR}/CMakeLists.txt" LOC_PATH)
if(EXISTS "${LOC_PATH}")
  message(
    FATAL_ERROR
      "You cannot build in a source directory (or any directory with "
      "CMakeLists.txt file). Please make a build subdirectory. Feel free to "
      "remove CMakeCache.txt and CMakeFiles.")
else()
  message(STATUS "Build directory check passed")
endif()
