cmake_minimum_required(VERSION 3.18)

# Vcpkg build environment
message(STATUS "VCPKG_ROOT:$ENV{VCPKG_ROOT}")
set(VCPKG_ROOT "$ENV{VCPKG_ROOT}")

# set cmake tool chain
set(CMAKE_TOOLCHAIN_FILE ${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake)

set(VCPKG_VERBOSE
    ON
    CACHE BOOL "Vcpkg VCPKG_VERBOSE")

# Project settings
project(
  cppblueprint
  LANGUAGES CXX # enable language check for cxx
  VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

message(STATUS "PROJECT_VRESION finally:${PROJECT_VERSION}")
message(STATUS "CMAKE_PROJECT_VERSION_MAJOR: ${CMAKE_PROJECT_VERSION_MAJOR}")
message(STATUS "CMAKE_PROJECT_VERSION_MINOR: ${CMAKE_PROJECT_VERSION_MINOR}")
message(STATUS "CMAKE_PROJECT_VERSION_PATCH: ${CMAKE_PROJECT_VERSION_PATCH}")
message(STATUS "CMAKE_PROJECT_VERSION_TWEAK: ${CMAKE_PROJECT_VERSION_TWEAK}")
message(STATUS "CMAKE_PROJECT_VERSION finally:${CMAKE_PROJECT_VERSION}")

message(STATUS "VCPKG_HOST_TRIPLET ${VCPKG_HOST_TRIPLET}")
message(STATUS "VCPKG_INSTALLED_DIR ${VCPKG_INSTALLED_DIR}")
message(STATUS "VCPKG_TARGET_TRIPLET ${VCPKG_TARGET_TRIPLET}")
message(STATUS "VCPKG_LIBRARY_LINKAGE ${VCPKG_LIBRARY_LINKAGE}")
message(STATUS "VCPKG_TARGET_IS_WINDOWS ${VCPKG_TARGET_IS_WINDOWS}")
message(STATUS "VCPKG_TARGET_IS_MINGW ${VCPKG_TARGET_IS_MINGW}")

include_directories(${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include)

# GNU install standard
include(GNUInstallDirs)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR})

set(INSTALL_LIBDIR
    ${CMAKE_INSTALL_LIBDIR}
    CACHE PATH "Installation directory for libraries")
set(INSTALL_BINDIR
    ${CMAKE_INSTALL_BINDIR}
    CACHE PATH "Installation directory for executables")
set(INSTALL_INCLUDEDIR
    ${CMAKE_INSTALL_INCLUDEDIR}
    CACHE PATH "Installation directory for header files")

set(DEF_INSTALL_CMAKEDIR share/${PROJECT_NAME})
set(INSTALL_CMAKEDIR
    ${DEF_INSTALL_CMAKEDIR}
    CACHE PATH "Installation directory for CMake files")

# CMake module tools import custom cmake modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(OSInstall)
include(ConfigValgrind)
include(PreCommit)
include(ConfigCcache)
include(ConfigIPO)
include(ConfigDocs)

# Runtime parallism
find_package(OpenMP REQUIRED)
# Runtime Polymorphism
find_package(proxy CONFIG REQUIRED)

# use, i.e. don't skip the full RPATH for the build tree
set(CMAKE_SKIP_BUILD_RPATH FALSE)

# when building, don't use the install RPATH already (but later on when
# installing)
set(CMAKE_BUILD_WITH_INSTALL_RPATH OFF)

if(CMAKE_HOST_UNIX)
  # add system bin auto dly-load such as
  list(APPEND CMAKE_INSTALL_RPATH
       "${CMAKE_INSTALL_PREFIX}/lib;${CMAKE_INSTALL_PREFIX}/bin;/usr/local/lib")
endif()

# add the automatically determined parts of the RPATH which point to directories
# outside the build tree to the install RPATH
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

message(STATUS "CMAKE_INSTALL_RPATH:${CMAKE_INSTALL_RPATH}")

# dynamic path specify the 3rd party short deps path depends on os-platform
set(dynamic_path $<IF:$<PLATFORM_ID:Windows>,bin,lib>)
message(STATUS "dynamic libraries path search: ${dynamic_path}")
set(my_dependency_paths
    ${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}$<IF:$<CONFIG:Debug>,/deubg/${dynamic_path},/${dynamic_path}>
)

# show installation directories
foreach(_p LIB BIN INCLUDE CMAKE)
  file(TO_NATIVE_PATH ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_${_p}DIR} _path)
  message(STATUS "Show installing ${_p} components to ${_path}")
  unset(_path)
endforeach()

# # sanitizer for memcheck for debug if(CMAKE_HOST_UNIX)
# set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}
# -fsanitize=address,undefined -fno-omit-frame-pointer" )
# set(CMAKE_LINKER_FLAGS_DEBUG "${CMAKE_LINKER_FLAGS_DEBUG}
# -fsanitize=address,undefined -fno-omit-frame-pointer" ) elseif()
# set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /fsanitize") endif()

add_subdirectory(src)

# tests
add_subdirectory(tests EXCLUDE_FROM_ALL)

# cmake-format: off
# CPack Configuration
# set(CPACK_PROJECT_NAME ${PROJECT_NAME})
# set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
# set(CPACK_PACKAGE_DIRECTORY ${CMAKE_BINARY_DIR})
# set(CPACK_PACKAGE_CONTACT "CppBlueprint@email.com")
# include(CPack)
# cmake-format: on
