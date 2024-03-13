# Building

A general guide on how to build the project is provided here. The project uses CMake as the build system and vcpkg as the package manager.

## Prerequisites

- [project creation](project_management.md)
- [development environment setup](development_environment.md)

## General Build Process

The general build process for the project is as follows:

- Ensure the compiler is installed and available in the system PATH.
- Configure the project using CMake and specify the desired build options.
- Build the project using the generated build system.
- Test the project to ensure it's working as expected.
- Install the project to make it available for use.

## Triplet Presets

Based on vcpkg and CMake, we create sets of triplet presets for different platforms and configurations. These presets can be seamlessly used to configure, build and test the project targeting different platforms and options. The available presets presets can be detected automatically by CMake CMakePresets.json file.

### With Presets

To build the project with presets refer to <https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html>, you can use the following commands:

```bash
cmake -S . --list-presets         # list all configure presets
cmake -S . --preset=<preset>      # configure using desired configure preset
cmake --build --list-presets      # list all build presets
cmake --build --preset=<preset>   # build the desired build preset
ctest --list-presets              # list all test presets
ctest --preset=<preset>           # test the desired test preset
```

### Without presets

You can also build the project without using presets. It's not recommended in production environments as it's more complex and error-prone because you need to specify the correct triplet and toolchain for each platform and configuration in manual way.

But it is documented here for reference to reveal the underlying mechanism which explains how the following variables are used to configure and build the project.

The Table below shows the necessary variables for different platforms and configurations:

| Variable               | Requirement | Description                             | Value                                                    |
|------------------------|-------------|-----------------------------------------|----------------------------------------------------------|
| CMAKE_TOOLCHAIN_FILE   | Required    | Path to the project's toolchain file    | cmake/vcpkg/vcpkg.toolchain.cmake                        |
| CMAKE_BUILD_TYPE       | Required    | Build configuration                     | Debug, Release, RelWithDebInfo, MinSizeRel               |
| CMAKE_GENERATOR        | Required    | Generator for the build system          | Ninja, Unix Makefiles, Visual Studio 16 2019, etc.       |
| VCPKG_ROOT             | Optional    | Path to a vcpkg installation directory. | vcpkg installation directory                             |
| VCPKG_TARGET_TRIPLET   | Required    | Target triplet                          | x86-windows, x64-windows, x64-linux, arm64-windows, etc. |
| VCPKG_HOST_TRIPLET     | Optional    | Host triplet                            | x86-windows, x64-windows, x64-linux, arm64-windows, etc. |
| VCPKG_OVERLAY_TRIPLETS | Optional    | Path to the overlay triplets directory  | cmake/vcpkg/triplets                                     |
| VCPKG_OVERLAY_PORTS    | Optional    | Path to the overlay ports directory     | cmake/vcpkg/ports                                        |

```{note}
 - `cmake/vcpkg/vcpkg.toolchain.cmake` contains the triplet and vcpkg environment initialization steps which loads triplet variables and chainload toolchain according to VCPKG_TARGET_TRIPLET.
 - `VCPKG_ROOT` is optional and it's used to specify the path to a vcpkg installation directory. If not specified, cmake/vcpkg/vcpkg.toolchain.cmake will automatically create one for you.
 - `CMAKE_GENERATOR` is recommended to use Ninja as it's faster than the default generator.
```

Here's an example of building the project with the specified variables:

```bash
# Configure
cmake -S . -B build \
    -DCMAKE_TOOLCHAIN_FILE=cmake/vcpkg/vcpkg.toolchain.cmake \
    -DCMAKE_BUILD_TYPE=Debug \
    -G Ninja \
    -DVCPKG_TARGET_TRIPLET=x64-linux \
    -DVCPKG_HOST_TRIPLET=x64-linux \
    -DVCPKG_OVERLAY_TRIPLETS=cmake/vcpkg/triplets \
    -DVCPKG_OVERLAY_PORTS=cmake/vcpkg/ports
# Build
cmake --build build --config Debug
# Testing
cd build && ctest -C Debug -T test --output-on-failure
# Memcheck
cd build && ctest -C Debug -T memcheck
# Install
cmake --build build --config Debug --target install
```

Most of the variables can refer to <https://learn.microsoft.com/en-us/vcpkg/users/buildsystems/cmake-integration>.


## Available Targets in the Project

The generated project provides the following targets:

- `all` - builds all targets in the project.
- `<repo_name>-docs` - builds the documentation.
- `coverage` - runs the tests.
- `install` - installs the project to the install directory.
- `uninstall` - uninstalls the project from the install directory.
