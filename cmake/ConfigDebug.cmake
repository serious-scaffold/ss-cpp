# Debug configuration
if(CMAKE_BUILD_TYPE STREQUAL Debug)
  add_definitions(-D_DEBUG)
  message(STATUS "Ensure _DEBUG is defined for Debug configuration")
endif()
