# we will use the network to fetch Google Test sources make it possible to
# disable unit tests when not on network
option(ENABLE_UNIT_TESTS "Enable unit tests" ON)
message(STATUS "Enable testing: ${ENABLE_UNIT_TESTS}")

if(ENABLE_UNIT_TESTS)

  # add memcheck test action
  include(CTest)
  enable_testing()

  # fatch googletest since 3.11
  include(FetchContent)

  FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG release-1.12.1)

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
