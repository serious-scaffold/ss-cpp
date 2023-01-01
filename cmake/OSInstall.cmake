# cmake-format: off
# A function to enable applocal install of dependencies as part of the `make install` process
# Arguments:
#   TARGETS - a list of installed targets to have dependencies copied for (required)
#   DESTINATION - the runtime directory for those targets (usually `bin`)
#   DIRECTORIES - the directories to search dependencies (required)
#   PRE_EXCLUDE_REGEXES - regular expressions to handle results (optional)
#   POST_EXCLUDE_REGEXES - regular expressions to handle results (optional)
#   POST_INCLUDE_REGEXES - regular expressions to handle results (optional)
#
# Note that this function requires CMake 3.14 for policy CMP0087
# cmake-format: on
function(install_local_dependencies)
  if(CMAKE_VERSION VERSION_LESS "3.16")
    message(FATAL_ERROR "install_local_dependencies require at least CMake 3.16
(current version: ${CMAKE_VERSION})")
  endif()

  cmake_parse_arguments(
    PARSE_ARGV
    "0"
    arg
    ""
    "DESTINATION"
    "TARGETS;DIRECTORIES;PRE_EXCLUDE_REGEXES;POST_EXCLUDE_REGEXES;POST_INCLUDE_REGEXES"
  )
  if(DEFINED arg_UNPARSED_ARGUMENTS)
    message(
      FATAL_ERROR
        "${CMAKE_CURRENT_FUNCTION} was passed extra arguments: ${arg_UNPARSED_ARGUMENTS}"
    )
  endif()

  if(NOT DEFINED arg_DIRECTORIES)
    message(WARNING "DEPENDENIDES DIRECTORIES must be specified")
  endif()

  if(NOT DEFINED arg_DESTINATION)
    set(arg_DESTINATION $<IF:$<PLATFORM_ID:Windows>,bin,lib>)
  endif()

  # Install CODE|SCRIPT allow the use of generator expressions
  cmake_policy(PUSH)
  # set CMP0087 install code for generator-expression
  if(POLICY CMP0048)
    cmake_policy(SET CMP0087 NEW)
  endif()

  if(NOT IS_ABSOLUTE "${arg_DESTINATION}")
    set(arg_DESTINATION "\${CMAKE_INSTALL_PREFIX}/${arg_DESTINATION}")
  endif()

  list(APPEND arg_POST_INCLUDE_REGEXES "")
  list(APPEND arg_PRE_EXCLUDE_REGEXES "")
  list(APPEND arg_POST_EXCLUDE_REGEXES "")
  if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
    list(
      APPEND
      arg_PRE_EXCLUDE_REGEXES
      "api-ms-.*"
      "ext-ms-.*"
      "ieshims.dll"
      "emclient.dll"
      "devicelockhelpers.dll"
      "python*.dll") # windows API
    list(APPEND arg_POST_EXCLUDE_REGEXES "WINDOWS" "system32") # system dlls
  elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
    list(
      APPEND
      arg_PRE_EXCLUDE_REGEXES
      "/cmov/"
      "ld-linux[\.\-]"
      "libc[\.\-]"
      "libdl[\.\-]"
      "libdrm[\.\-]"
      "libelf[\.\-]"
      "libexpat[\.\-]"
      "libfontconfig[\.\-]"
      "libfreetype[\.\-]"
      "libg[\.\-]"
      "libgcc_s[\.\-]"
      "libGL[\.\-]"
      "libglib[\.\-]"
      "libgthread[\.\-]"
      "lib(ice|ICE)[\.\-]"
      "libnvidia[\.\-]"
      "libpthread[\.\-]"
      "libse(pol|linux)[\.\-]"
      "libSM[\.\-]"
      "libm[\.\-]"
      "librt[\.\-]"
      "libstdc[\+][\+][\.\-]"
      "libX[a-zA-Z0-9]*[\.\-]"
      "libxcb[\.\-]"
      "libutil[\.]"
      "libomp[\.]"
      "libgomp[\.]" # omp lib
      "libpthread[\.]" # pthread lib
      "libpython" # python lib
      "pylibc[\.\-]") # Linux API
  else()
    message(
      FATAL_ERROR "We can not confirm the current platform when installing")
  endif()

  install(CODE "set(arg_DIRECTORIES \"${arg_DIRECTORIES}\")")
  install(CODE "set(arg_PRE_EXCLUDE_REGEXES \"${arg_PRE_EXCLUDE_REGEXES}\")")
  install(CODE "set(arg_POST_EXCLUDE_REGEXES \"${arg_POST_EXCLUDE_REGEXES}\")")
  install(CODE "set(arg_POST_INCLUDE_REGEXES \"${arg_POST_INCLUDE_REGEXES}\")")
  install(CODE "set(arg_DESTINATION \"${arg_DESTINATION}\")")
  foreach(target IN LISTS arg_TARGETS)
    get_target_property(target_type "${target}" TYPE)
    message(STATUS "target_type:${target_type};$<TARGET_FILE_NAME:${target}>")
    if(NOT target_type STREQUAL "INTERFACE_LIBRARY")

      install(CODE "set(target_type \"${target_type}\")")
      install(CODE "set(target \"$<TARGET_FILE:${target}>\")")
      install(
        CODE [[
            set(library_target "")
            set(executable_target "")
            if(target_type STREQUAL "SHARED_LIBRARY")
            set(library_target ${target})
            elseif(target_type STREQUAL "EXECUTABLE")
            set(executable_target ${target})
            endif()
            file(
                GET_RUNTIME_DEPENDENCIES
                EXECUTABLES
                ${executable_target}
                LIBRARIES
                ${library_target}
                RESOLVED_DEPENDENCIES_VAR
                _r_deps
                UNRESOLVED_DEPENDENCIES_VAR
                _u_deps
                CONFLICTING_DEPENDENCIES_PREFIX
                _c_deps
                DIRECTORIES
                ${arg_DIRECTORIES}
                PRE_EXCLUDE_REGEXES
                ${arg_PRE_EXCLUDE_REGEXES}
                POST_EXCLUDE_REGEXES
                ${arg_POST_EXCLUDE_REGEXES}
                POST_INCLUDE_REGEXES
                ${arg_POST_INCLUDE_REGEXES})
            message(STATUS "_r_deps: ${_r_deps}")
            message(STATUS "_u_deps: ${_u_deps}")
            message(STATUS "_c_deps: ${_c_deps_FILENAMES}")
            foreach(_file ${_r_deps})
                file(
                    INSTALL
                    DESTINATION "${arg_DESTINATION}"
                    TYPE SHARED_LIBRARY FOLLOW_SYMLINK_CHAIN FILES "${_file}")
            endforeach()

            list(LENGTH _u_deps _u_length)
            if("${_u_length}" GREATER 0)
                message(WARNING "Unresolved dependencies detected:${_u_deps}")
            endif()

            foreach(_filename ${_c_deps_FILENAMES})
                set(_c_file_list ${_c_deps_${_filename}})
                message(STATUS "conflict ${_filename} list ${_c_file_list}")
                foreach(_file ${_c_file_list})
                    file(
                        INSTALL
                        DESTINATION "${arg_DESTINATION}"
                        TYPE SHARED_LIBRARY FOLLOW_SYMLINK_CHAIN FILES "${_file}")
                endforeach()
            endforeach()
      ]])
    endif()
  endforeach()
  cmake_policy(POP)
endfunction()
