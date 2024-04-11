# Triplet Presets

The triplet presets we created for our projects are stored in the `cmake/presets` directory and can be used to configure, build, and test our projects with different platforms and configurations. Because it follows a standardized naming convention based on the vcpkg [triplets](https://learn.microsoft.com/en-us/vcpkg/users/triplets), it is easy to use and understand.

## Triplet Preset Naming Convention

A triplet preset is a JSON file following the syntax of CMake CMakePresets.json format. The naming convention for the triplet preset file is as follows: `<Architecture>-<Target Compiling OS/Toolchain>-<Distribution>-<Compiler>.json`. It basically consists of the pattern of those parts: Architecture, Target-Compiling-Os/Toolchain, Distribution and Compiler(Optional).

- Architecture: x86, x64, arm, arm64, ppc64le, s390x, wasm32, etc.
- Target Compiling OS/Toolchain: windows, linux, macos, freebsd, android, ios, mingw, etc.
- Distribution(Optional): dynamic, static, release, etc.
- Compiler(Optional): MSVC, GCC, Clang, MinGW, etc.


## Triplet Preset Customization

To customize a triplet preset, we can refer to the existing triplet preset files in the `cmake/presets` directory and extend or modify them as per our requirements.

### Preset Folder Structure

The `cmake/presets` directory contains the following subfolders:

- `arch`: Contains different architectures (e.g. x86, x64, arm, arm64, etc.).
- `compilers`: Contains different compilers (e.g. MSVC, GCC, Clang, etc.).
- `generators`: Contains different cmake supported generators (e.g. Ninja, Unix Makefiles, etc.).
- `os`: Contains different operating systems (e.g. Windows, Linux, macOS, etc.).
- `toolchains`: Contains vcpkg toolchain loadings (only vcpkg).
- `triplets`: Contains the triples conforming to the vcpkg triplet naming convention (e.g. x64-windows, x64-linux, etc.).
- `.`: Contains all configured triplet preset files.


### Best Practices

Here are some best practices to follow while creating a triplet preset:

- The triplet preset file should be named as `<Architecture>-<Target Compiling OS/Toolchain>-<Distribution>-<Compiler>.json`.
- Conform to the existing triplet presets' folder structure.
- Use existing components if possible.
