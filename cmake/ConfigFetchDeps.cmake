#[=======================================================================[.rst:
Fetch Deps
----------

Deps list:
- abseil
# - protobuff
# - grpc

#]=======================================================================]

include(FetchContent)

# Open FetchContent fetching logs.
set(FETCHCONTENT_QUIET OFF)

# abseil
FetchContent_Declare(
  abseil
  GIT_REPOSITORY https://github.com/abseil/abseil-cpp.git
  GIT_TAG 20230125.0)
FetchContent_MakeAvailable(abseil)
