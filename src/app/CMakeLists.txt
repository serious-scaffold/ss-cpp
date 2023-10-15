set(app ${CMAKE_PROJECT_NAME}_app)

add_executable(${app} main.cpp)
copy_sanitizer_runtime(${app})

target_link_libraries(${app} PRIVATE api-shared absl::log_initialize)

install(
  TARGETS ${app}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

install_dependency(TARGETS ${app} DIRECTORIES ${RUNPATH_VCPKG_DPENDENCY_PATH})
