#
# Copyright (C) 2018-2022 by George Cave - gcave@stablecoder.ca
#
# Copyright (c) 2022, 2023 msclock - msclock@qq.com
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
#
# See https://github.com/StableCoder/cmake-scripts/blob/main/sanitizers.cmake.
# ---------------
# Sanitizers are tools that perform checks during a program’s runtime and
# returns issues, and as such, along with unit testing, code coverage and static
# analysis, is another tool to add to the programmers toolbox. And of course,
# like the previous tools, are tragically simple to add into any project using
# CMake, allowing any project and developer to quickly and easily use.
#
# A quick rundown of the tools available, and what they do:
#
# LeakSanitizer detects memory leaks, or issues where memory is allocated and
# never deallocated, causing programs to slowly consume more and more memory,
# eventually leading to a crash.
#
# AddressSanitizer is a fast memory error detector. It is useful for detecting
# most issues dealing with memory, such as:
# ~~~
# - Out of bounds accesses to heap, stack, global
# - Use after free
# - Use after return
# - Use after scope
# - Double-free, invalid free
# - Memory leaks (using LeakSanitizer)
# ~~~
#
# ThreadSanitizer detects data races for multi-threaded code.
#
# UndefinedBehaviourSanitizer detects the use of various features of C/C++ that
# are explicitly listed as resulting in undefined behaviour. Most notably:
# ~~~
# - Using misaligned or null pointer.
# - Signed integer overflow
# - Conversion to, from, or between floating-point types which would overflow the destination
# - Division by zero
# - Unreachable code
# ~~~
#
# MemorySanitizer detects uninitialized reads.
#
# Control Flow Integrity is designed to detect certain forms of undefined
# behaviour that can potentially allow attackers to subvert the program's
# control flow. These are used by declaring the USE_SANITIZER CMake variable as
# string containing any of:
# ~~~
# - Address
# - Memory
# - MemoryWithOrigins
# - Undefined
# - Thread
# - Leak
# - CFI
# ~~~
# Multiple values are allowed, e.g. -DUSE_SANITIZER=Address,Leak but some
# sanitizers cannot be combined together, e.g.-DUSE_SANITIZER=Address,Memory
# will result in configuration error. The delimiter character is not required
# and -DUSE_SANITIZER=AddressLeak would work as well.

include(CheckCXXSourceCompiles)

set(USE_SANITIZER
    ""
    CACHE
      STRING
      "Compile with a sanitizer. Options are: Address, Memory, MemoryWithOrigins, Undefined, Thread, Leak, 'Address;Undefined', CFI"
)

function(append value)
  foreach(variable ${ARGN})
    set(${variable}
        "${${variable}} ${value}"
        PARENT_SCOPE)
  endforeach(variable)
endfunction()

function(append_quoteless value)
  foreach(variable ${ARGN})
    set(${variable}
        ${${variable}} ${value}
        PARENT_SCOPE)
  endforeach(variable)
endfunction()

function(test_san_flags return_var flags)
  set(QUIET_BACKUP ${CMAKE_REQUIRED_QUIET})
  set(CMAKE_REQUIRED_QUIET TRUE)
  unset(${return_var} CACHE)
  set(FLAGS_BACKUP ${CMAKE_REQUIRED_FLAGS})
  set(CMAKE_REQUIRED_FLAGS "${flags}")
  check_cxx_source_compiles("int main() { return 0; }" ${return_var})
  set(CMAKE_REQUIRED_FLAGS "${FLAGS_BACKUP}")
  set(CMAKE_REQUIRED_QUIET "${QUIET_BACKUP}")
endfunction()

#[[=[
A function to copy sanitizer runtime when open ASAN flags on windows.Basically,
it copy clang_rt.asan*.dll to target location.
Arguments:
  target - a target added by add_library, add_executable instructions.
=]]
function(copy_sanitizer_runtime target)
  if(NOT WIN32 OR NOT USE_SANITIZER)
    return()
  endif()

  if(CMAKE_SIZEOF_VOID_P EQUAL 8) # 64-bit build
    set(ASAN_ARCHITECTURE "x86_64")
    set(ASAN_LIBRARY_HINT_DIR $ENV{VCToolsInstallDir}/bin/Hostx64/x64)
  else()
    set(ASAN_ARCHITECTURE "i386")
    set(ASAN_LIBRARY_HINT_DIR $ENV{VCToolsInstallDir}/bin/Hostx86/x86)
  endif()

  if(CMAKE_BUILD_TYPE STREQUAL Debug)
    set(ASAN_LIBRARY_NAME "clang_rt.asan_dbg_dynamic-${ASAN_ARCHITECTURE}.dll")
  else()
    set(ASAN_LIBRARY_NAME "clang_rt.asan_dynamic-${ASAN_ARCHITECTURE}.dll")
  endif()
  set(LLVM_SYMBOLIZER_NAME "llvm-symbolizer.exe")

  set(CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS ${ASAN_LIBRARY_NAME})
  find_file(
    ASAN_LIBRARY_SOURCE
    NAMES ${ASAN_LIBRARY_NAME} REQUIRED
    HINTS ${ASAN_LIBRARY_HINT_DIR} $ENV{LIBPATH}
    DOC "Clang AddressSanitizer runtime")

  find_file(
    LLVM_SYMBOLIZER_SOURCE
    NAMES ${LLVM_SYMBOLIZER_NAME} REQUIRED
    HINTS ${ASAN_LIBRARY_HINT_DIR} $ENV{LIBPATH}
    DOC "LLVM symbolizer executable")

  add_custom_command(
    COMMENT "Copying ${ASAN_LIBRARY_SOURCE} to $<TARGET_FILE_DIR:${target}>"
    MAIN_DEPENDENCY ${ASAN_LIBRARY_SOURCE}
    TARGET ${target} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${ASAN_LIBRARY_SOURCE}
            $<TARGET_FILE_DIR:${target}>)

  add_custom_command(
    COMMENT "Copying ${LLVM_SYMBOLIZER_SOURCE} to $<TARGET_FILE_DIR:${target}>"
    MAIN_DEPENDENCY ${LLVM_SYMBOLIZER_SOURCE}
    TARGET ${target} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${LLVM_SYMBOLIZER_SOURCE}
            $<TARGET_FILE_DIR:${target}>)

endfunction()

if(USE_SANITIZER)

  unset(SANITIZER_SELECTED_FLAGS)
  if(NOT MSVC AND CMAKE_HOST_UNIX)
    append("-fno-omit-frame-pointer" CMAKE_C_FLAGS CMAKE_CXX_FLAGS)
    if(uppercase_CMAKE_BUILD_TYPE STREQUAL "DEBUG")
      append("-O1" CMAKE_C_FLAGS CMAKE_CXX_FLAGS)
    endif()

    if(USE_SANITIZER MATCHES "([Aa]ddress)")
      # Optional: -fno-optimize-sibling-calls -fsanitize-address-use-after-scope
      message(STATUS "Testing with Address sanitizer")
      set(SANITIZER_ADDR_FLAG "-fsanitize=address")
      test_san_flags(SANITIZER_ADDR_AVAILABLE ${SANITIZER_ADDR_FLAG})
      if(SANITIZER_ADDR_AVAILABLE)
        message(STATUS "  Building with Address sanitizer")
        append("${SANITIZER_ADDR_FLAG}" SANITIZER_SELECTED_FLAGS)

        if(AFL)
          append_quoteless(AFL_USE_ASAN=1 CMAKE_C_COMPILER_LAUNCHER
                           CMAKE_CXX_COMPILER_LAUNCHER)
        endif()
      else()
        message(
          FATAL_ERROR
            "Address sanitizer not available for ${CMAKE_CXX_COMPILER}")
      endif()
    endif()

    if(USE_SANITIZER MATCHES "([Mm]emory([Ww]ith[Oo]rigins)?)")
      # Optional: -fno-optimize-sibling-calls -fsanitize-memory-track-origins=2
      set(SANITIZER_MEM_FLAG "-fsanitize=memory")
      if(USE_SANITIZER MATCHES "([Mm]emory[Ww]ith[Oo]rigins)")
        message(STATUS "Testing with MemoryWithOrigins sanitizer")
        append("-fsanitize-memory-track-origins" SANITIZER_MEM_FLAG)
      else()
        message(STATUS "Testing with Memory sanitizer")
      endif()
      test_san_flags(SANITIZER_MEM_AVAILABLE ${SANITIZER_MEM_FLAG})
      if(SANITIZER_MEM_AVAILABLE)
        if(USE_SANITIZER MATCHES "([Mm]emory[Ww]ith[Oo]rigins)")
          message(STATUS "  Building with MemoryWithOrigins sanitizer")
        else()
          message(STATUS "  Building with Memory sanitizer")
        endif()
        append("${SANITIZER_MEM_FLAG}" SANITIZER_SELECTED_FLAGS)

        if(AFL)
          append_quoteless(AFL_USE_MSAN=1 CMAKE_C_COMPILER_LAUNCHER
                           CMAKE_CXX_COMPILER_LAUNCHER)
        endif()
      else()
        message(
          FATAL_ERROR
            "Memory [With Origins] sanitizer not available for ${CMAKE_CXX_COMPILER}"
        )
      endif()
    endif()

    if(USE_SANITIZER MATCHES "([Uu]ndefined)")
      message(STATUS "Testing with Undefined Behaviour sanitizer")
      set(SANITIZER_UB_FLAG "-fsanitize=undefined")
      if(EXISTS "${BLACKLIST_FILE}")
        append("-fsanitize-blacklist=${BLACKLIST_FILE}" SANITIZER_UB_FLAG)
      endif()
      test_san_flags(SANITIZER_UB_AVAILABLE ${SANITIZER_UB_FLAG})
      if(SANITIZER_UB_AVAILABLE)
        message(STATUS "  Building with Undefined Behaviour sanitizer")
        append("${SANITIZER_UB_FLAG}" SANITIZER_SELECTED_FLAGS)

        if(AFL)
          append_quoteless(AFL_USE_UBSAN=1 CMAKE_C_COMPILER_LAUNCHER
                           CMAKE_CXX_COMPILER_LAUNCHER)
        endif()
      else()
        message(
          FATAL_ERROR
            "Undefined Behaviour sanitizer not available for ${CMAKE_CXX_COMPILER}"
        )
      endif()
    endif()

    if(USE_SANITIZER MATCHES "([Tt]hread)")
      message(STATUS "Testing with Thread sanitizer")
      set(SANITIZER_THREAD_FLAG "-fsanitize=thread")
      test_san_flags(SANITIZER_THREAD_AVAILABLE ${SANITIZER_THREAD_FLAG})
      if(SANITIZER_THREAD_AVAILABLE)
        message(STATUS "  Building with Thread sanitizer")
        append("${SANITIZER_THREAD_FLAG}" SANITIZER_SELECTED_FLAGS)

        if(AFL)
          append_quoteless(AFL_USE_TSAN=1 CMAKE_C_COMPILER_LAUNCHER
                           CMAKE_CXX_COMPILER_LAUNCHER)
        endif()
      else()
        message(
          FATAL_ERROR "Thread sanitizer not available for ${CMAKE_CXX_COMPILER}"
        )
      endif()
    endif()

    if(USE_SANITIZER MATCHES "([Ll]eak)")
      message(STATUS "Testing with Leak sanitizer")
      set(SANITIZER_LEAK_FLAG "-fsanitize=leak")
      test_san_flags(SANITIZER_LEAK_AVAILABLE ${SANITIZER_LEAK_FLAG})
      if(SANITIZER_LEAK_AVAILABLE)
        message(STATUS "  Building with Leak sanitizer")
        append("${SANITIZER_LEAK_FLAG}" SANITIZER_SELECTED_FLAGS)

        if(AFL)
          append_quoteless(AFL_USE_LSAN=1 CMAKE_C_COMPILER_LAUNCHER
                           CMAKE_CXX_COMPILER_LAUNCHER)
        endif()
      else()
        message(
          FATAL_ERROR "Thread sanitizer not available for ${CMAKE_CXX_COMPILER}"
        )
      endif()
    endif()

    if(USE_SANITIZER MATCHES "([Cc][Ff][Ii])")
      message(STATUS "Testing with Control Flow Integrity(CFI) sanitizer")
      set(SANITIZER_CFI_FLAG "-fsanitize=cfi")
      test_san_flags(SANITIZER_CFI_AVAILABLE ${SANITIZER_CFI_FLAG})
      if(SANITIZER_CFI_AVAILABLE)
        message(STATUS "  Building with Control Flow Integrity(CFI) sanitizer")
        append("${SANITIZER_LEAK_FLAG}" SANITIZER_SELECTED_FLAGS)

        if(AFL)
          append_quoteless(AFL_USE_CFISAN=1 CMAKE_C_COMPILER_LAUNCHER
                           CMAKE_CXX_COMPILER_LAUNCHER)
        endif()
      else()
        message(
          FATAL_ERROR
            "Control Flow Integrity(CFI) sanitizer not available for ${CMAKE_CXX_COMPILER}"
        )
      endif()
    endif()

    message(STATUS "Sanitizer flags: ${SANITIZER_SELECTED_FLAGS}")
    test_san_flags(SANITIZER_SELECTED_COMPATIBLE ${SANITIZER_SELECTED_FLAGS})
    if(SANITIZER_SELECTED_COMPATIBLE)
      message(STATUS " Building with ${SANITIZER_SELECTED_FLAGS}")
      append("${SANITIZER_SELECTED_FLAGS}" CMAKE_C_FLAGS CMAKE_CXX_FLAGS)
    else()
      message(
        FATAL_ERROR
          " Sanitizer flags ${SANITIZER_SELECTED_FLAGS} are not compatible.")
    endif()
  elseif(MSVC)
    if(USE_SANITIZER MATCHES "([Aa]ddress)")
      message(STATUS "Building with MSVC sanitizer")
      # https://learn.microsoft.com/en-us/answers/questions/864574/enabling-address-sanitizer-results-in-error-lnk203
      # https://learn.microsoft.com/en-us/cpp/sanitizers/error-container-overflow?view=msvc-170
      add_compile_definitions(_DISABLE_VECTOR_ANNOTATION)
      append("${CMAKE_CXX_FLAGS} /fsanitize=address" CMAKE_CXX_FLAGS)
      append("${CMAKE_C_FLAGS} /fsanitize=address" CMAKE_C_FLAGS)
      if(AFL)
        append_quoteless(AFL_USE_ASAN=1 CMAKE_C_COMPILER_LAUNCHER
                         CMAKE_CXX_COMPILER_LAUNCHER)
      endif()

    else()
      # llvm tool chain has same definition which is conflicit on windows with
      # symbol _calloc_dbg.
      message(
        FATAL_ERROR
          "This sanitizer not yet supported in the MSVC environment: ${USE_SANITIZER}"
      )
    endif()
  else()
    message(FATAL_ERROR "USE_SANITIZER is not supported on this platform.")
  endif()

endif()
