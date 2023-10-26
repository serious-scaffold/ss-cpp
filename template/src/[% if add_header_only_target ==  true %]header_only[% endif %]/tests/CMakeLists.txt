file(GLOB files "*.cpp")

foreach(_file ${files})
  get_filename_component(file_basename ${_file} NAME_WE)
  add_executable(${file_basename} ${_file})
  target_link_libraries(${file_basename} PRIVATE GTest::gtest_main header_only)
  target_code_coverage(${file_basename} ALL)
  gtest_discover_tests(${file_basename})
  copy_sanitizer_runtime(${file_basename})

  # add_test(NAME ${file_basename}_test COMMAND $<TARGET_FILE:${file_basename}>)
endforeach()
