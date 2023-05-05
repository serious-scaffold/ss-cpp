#[=======================================================================[.rst:
Config Fetch Deps
----------

Optional deps list:
  - abseil: it has managed by vcpkg.

An example for abseil fetching:

.. code-block:: cmake

  # abseil builds in a static mode preferentially
  FetchContent_Declare(
    abseil
    GIT_REPOSITORY https://github.com/abseil/abseil-cpp.git
    GIT_TAG 20230125.1)

  if(WIN32)
    # dll build on windows as default
    set(ABSL_BUILD_DLL ON)
  else()
    # static build on non-windows as default
    set(ABSL_BUILD_DLL OFF)
  endif()

  FetchContent_MakeAvailable(abseil)

#]=======================================================================]

include(FetchContent)

message(STATUS "Register fetching extra deps...")

# extra deps here

FetchContent_MakeAvailable()

message(STATUS "Register fetching extra deps done")
