# we will use the network to fetch Google Test sources make it possible to
# disable unit tests when not on network
message(STATUS "Enable testing: ${BUILD_TESTING}")
if(BUILD_TESTING)
  # fetch googletest since cmake > 3.11
  include(FetchContent)

  FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG 3d787f5a0d58cfc37a0563bb15647a0d8aa2c1bf)

  # For Windows: Prevent overriding the parent project's compiler/linker
  # settings

  set(gtest_force_shared_crt
      ON
      CACHE BOOL "" FORCE)

  FetchContent_MakeAvailable(googletest)

  include(GoogleTest)

  # app test module
  add_subdirectory(app)
endif()
