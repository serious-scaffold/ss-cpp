find_package(GTest CONFIG REQUIRED)

include(GoogleTest)

file(GLOB files "*.cpp")

foreach(_file ${files})
  get_filename_component(file_basename ${_file} NAME_WE)
  add_executable(${file_basename} ${_file})
  target_link_libraries(${file_basename} PRIVATE GTest::gtest_main
                                                 compile_module)
  target_compile_features(${file_basename} PUBLIC cxx_std_23)
  set_property(TARGET ${file_basename} PROPERTY CXX_SCAN_FOR_MODULES ON)
  warn_target(${file_basename})
  harden_target(${file_basename})
  sanitize_target(${file_basename})
  target_code_coverage(${file_basename} ALL)
  gtest_discover_tests(${file_basename})
endforeach()
