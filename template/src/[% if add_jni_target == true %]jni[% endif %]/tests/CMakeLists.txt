# create a jar in cmake, see
# https://stackoverflow.com/questions/14542872/what-is-the-correct-way-to-use-add-jar-with-java-bindings-produced-by-swig

file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/class)
file(GLOB java_files "java/*.java")
add_custom_command(
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/build.jar
  COMMAND ${Java_JAVAC_EXECUTABLE} -d ${CMAKE_CURRENT_BINARY_DIR}/class
          ${java_files}
  COMMAND ${Java_JAR_EXECUTABLE} -cfM ${CMAKE_CURRENT_BINARY_DIR}/build.jar -C
          ${CMAKE_CURRENT_BINARY_DIR}/class .
  DEPENDS ${java_files}
  VERBATIM)
add_jar(test_jar SOURCE ${CMAKE_CURRENT_SOURCE_DIR}/java/MyTest.java
        INCLUDE_JARS ${CMAKE_CURRENT_BINARY_DIR}/build.jar)
add_custom_command(
  TARGET test_jar
  POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy_if_different
          ${CMAKE_CURRENT_BINARY_DIR}/test_jar.jar ${CMAKE_BINARY_DIR}/bin
  VERBATIM)

file(GLOB files "*.cpp")
foreach(_file ${files})
  get_filename_component(file_basename ${_file} NAME_WE)
  add_executable(${file_basename} ${_file})
  target_link_libraries(${file_basename} PRIVATE GTest::gtest_main jni
                                                 absl::log)
  target_code_coverage(${file_basename} ALL)
  gtest_discover_tests(${file_basename})
  copy_sanitizer_runtime(${file_basename})
  add_dependencies(${file_basename} test_jar)
endforeach()
