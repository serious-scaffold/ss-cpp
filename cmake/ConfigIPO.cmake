# optimization for linking
macro(config_ipo)
  # for ipo optimization
  include(CheckIPOSupported)
  check_ipo_supported(RESULT result)
  if("${result}" STREQUAL "YES" AND "${CMAKE_BUILD_TYPE}" STREQUAL "Release")
    message(STATUS "Enable lto optimization for release")
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE ON)
  else()
    message(STATUS "Disable lto optimization for no-release")
  endif()
endmacro(config_ipo)

config_ipo()
