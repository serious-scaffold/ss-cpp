#[=======================================================================[.rst:
Fetch Deps
----------

Deps list:
# - abseil
# - protobuff
# - grpc

#]=======================================================================]

include(FetchContent)

#[[===
# abseil fetching example

# abseil builds in a static mode preferentially
```cmake
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
```

===]]

message(STATUS "Register fetching extra deps")
