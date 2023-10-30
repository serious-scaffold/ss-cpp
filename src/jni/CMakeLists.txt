set(target_name jni)

find_package(JNI REQUIRED)
find_package(Java REQUIRED)
include(UseJava)

add_library(${target_name} INTERFACE)

target_include_interface_directories(
  ${target_name} ${JNI_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_BINARY_DIR}/git/include)

target_link_libraries(${target_name} INTERFACE absl::log ${JAVA_JVM_LIBRARY})

install_target(
  NAME
  ${target_name}
  VERSION
  ${CMAKE_PROJECT_VERSION}
  TARGETS
  ${target_name}
  INCLUDES
  ${CMAKE_CURRENT_SOURCE_DIR}/include/
  ${CMAKE_BINARY_DIR}/git/include/
  LICENSE_FILE_LIST
  ${CMAKE_SOURCE_DIR}/LICENSE
  DEPENDENCIES
  absl::log
  PRE_EXCLUDE_REGEXES
  "jvm\.*")

# Test
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()
