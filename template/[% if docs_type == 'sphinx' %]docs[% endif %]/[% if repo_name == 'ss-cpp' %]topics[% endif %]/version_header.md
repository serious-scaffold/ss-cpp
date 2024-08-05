# Version Header

The version header is a file that contains a version number and other metadata about the software and is used to track the version of the software and to provide information about the build environment. The generation compses of two parts: [Version Detection](#version-detection) and [Header Generation](#header-generation).

## Version Detection

The cmake module `cmake/ConfigureVersion.cmake` based on the git commands detects the git commit information and sets the following version number accordingly:

- CMAKE_PROJECT_GIT_COMMIT_*: git commit information
- CMAKE_PROJECT_VERSION: version number (major.minor.patch.tweak)
- CMAKE_PROJECT_VERSION_<MAJOR|MINOR|PATCH|TWEAK>: version numbers (as integers)

```{note}
It is set to `0.0.0.0` by default when not any git commit information is detected or the project is not inited as a git repository.
```

## Header Generation

There's a cmake command [`generate_git_header`](https://github.com/msclock/cmake-modules/blob/master/cmake/configure/GitTools.cmake) from the modules of [cmake-modules](https://github.com/msclock/cmake-modules) that generates a C++ header file with the version information. The command takes the following arguments:

- `CONFIGURE_HEADER_FILE` - git header configuration content.
    Default to ${CMAKE_CURRENT_BINARY_DIR}/git_version_template/_version.hpp.in (optional)
- `DESTINATION` - git header destination to generate.
    Default to ${CMAKE_CURRENT_BINARY_DIR}/git_version/_version.hpp (optional)
- `VERSION_NAMESPACE_PREFIX` - namespace prefix for the generated cxx header.
    Default to ${CMAKE_PROJECT_NAME} (optional)

Based on the generate_git_header usage, we can customize the template header file placed in `${CMAKE_CURRENT_SOURCE_DIR}/version_header.in` to generate a desired version header with a template copy of the `${CMAKE_CURRENT_BINARY_DIR}/git_version_template/_version.hpp.in` by:

```cmake
generate_git_header(
    VERSION_NAMESPACE_PREFIX my_version
    CONFIGURE_HEADER_FILE ${CMAKE_CURRENT_SOURCE_DIR}/version_header.in
)
```

Then the generated header can be included in the source code.
