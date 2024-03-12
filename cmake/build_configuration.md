# Build Congfiguration

Based on vcpkg and CMake, we can seamlessly create, build, and test our projects on different platforms and configurations. Here are some tips and tricks to make things easier.

## Triplet Presets

The triplet presets are used to specify the target platform and build configuration for the project.It consists of three parts: Architecture, Target-Compiling-Os/Toolchain, Distribution and Compiler.

- Architecture: x86, x64, arm, arm64, ppc64le, s390x, wasm32, etc.
- Target-Compiling-OS/Toolchain: windows, linux, macos, freebsd, android, ios, mingw, etc.
- Distribution: dynamic, static, release, etc.
- Compiler: MSVC, GCC, Clang, MinGW.

More about triplets, see: <https://learn.microsoft.com/en-us/vcpkg/users/triplets>

## Building with Presets

To build the project with presets refer to <https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html>, you can use the following commands:

```bash
cmake -S . --list-presets         # list all configure presets
cmake -S . --preset=<preset>      # configure using desired configure preset
cmake --build --list-presets      # list all build presets
cmake --build --preset=<preset>   # build the desired build preset
ctest --list-presets              # list all test presets
ctest --preset=<preset>           # test the desired test preset
```

## Building without presets(Not Recommended)

You can also build the project without using presets. It's not recommended as it's more complex and error-prone because you need to specify the correct triplet and toolchain for each platform and configuration.

But it is documented here for reference to reveal the underlying mechanism. Here are some necessary variables to configure the project:

- `CMAKE_TOOLCHAIN_FILE(Required)`: specify the path to the project's toolchain file(cmake/vcpkg/vcpkg.toolchain.cmake). It contains steps to set the correct triplet and initialize the vcpkg environment. More importantly, it also loads triplet variables and chainload toolchain according to `VCPKG_TARGET_TRIPLET`.
- `CMAKE_BUILD_TYPE(Required)`: specify the build configuration, such as "Debug", "Release", "RelWithDebInfo", "MinSizeRel", etc.
- `CMAKE_GENERATOR(Required)`: specify the generator for the build system, such as "Ninja", "Unix Makefiles", "Visual Studio 16 2019", etc. And it's recommended to use Ninja for cross-platform builds.
- `VCPKG_ROOT(Optional)`: specify the path to the toolchain file for the target platform. Normally it's in the vcpkg installation directory. If not specified, cmake/vcpkg/vcpkg.toolchain.cmake will automatically create one for you.
- `VCPKG_TARGET_TRIPLET(Required)`: specify the target triplet.
- `VCPKG_HOST_TRIPLET(Optional)`: specify the host triplet and it can be detected automatically by vcpkg.
- `VCPKG_OVERLAY_TRIPLETS(Optional)`: specify the path to the overlay triplets directory.
- `VCPKG_OVERLAY_PORTS(Optional)`: specify the path to the overlay ports directory.

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
