#[[
Example:

  # add executable
  add_executable(main main.cpp)

  # add dependencies using cpm module
  CPMAddPackage("gh:fmtlib/fmt#7.1.3")
  CPMAddPackage("gh:nlohmann/json@3.10.5")
  CPMAddPackage("gh:catchorg/Catch2@3.2.1")

  # link dependencies
  target_link_libraries(main fmt::fmt nlohmann_json::nlohmann_json Catch2::Catch2WithMain)

]]

find_package(cmake-cpm REQUIRED)
include(cmake-cpm/CPM)

message(STATUS "Fetching extra deps...")

# Add extra deps here
