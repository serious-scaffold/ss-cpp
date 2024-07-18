# Serious Scaffold Cpp

A continuously evolving basic template for cpp development.

[![Documentation](https://img.shields.io/badge/Documentation-sphinx-blue)](https://serious-scaffold.github.io/ss-cpp)
[![License](https://img.shields.io/github/license/serious-scaffold/ss-cpp)](https://github.com/serious-scaffold/ss-cpp/blob/master/LICENSE)
[![SS Cpp](https://img.shields.io/badge/Serious%20Scaffold-c++-blue)](https://github.com/serious-scaffold/ss-cpp)

[![CI](https://github.com/serious-scaffold/ss-cpp/actions/workflows/ci.yml/badge.svg)](https://github.com/serious-scaffold/ss-cpp/actions/workflows/ci.yml)
[![CD](https://github.com/serious-scaffold/ss-cpp/actions/workflows/cd.yml/badge.svg)](https://github.com/serious-scaffold/ss-cpp/actions/workflows/cd.yml)
[![Renovate](https://github.com/serious-scaffold/ss-cpp/actions/workflows/renovate.yml/badge.svg)](https://github.com/serious-scaffold/ss-cpp/actions/workflows/renovate.yml)
[![Semantic Release](https://github.com/serious-scaffold/ss-cpp/actions/workflows/semantic-release.yml/badge.svg)](https://github.com/serious-scaffold/ss-cpp/actions/workflows/semantic-release.yml)
[![codecov](https://codecov.io/gh/serious-scaffold/ss-cpp/branch/master/graph/badge.svg?token=123456789)](https://codecov.io/gh/serious-scaffold/ss-cpp)
[![Release](https://img.shields.io/github/v/release/serious-scaffold/ss-cpp)](https://github.com/serious-scaffold/ss-cpp/releases)

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![clang-format](https://img.shields.io/badge/clang--format-enabled-blue)](https://github.com/pre-commit/mirrors-clang-format)
[![cmake-format](https://img.shields.io/badge/cmake--format-enabled-blue)](https://github.com/cheshirekow/cmake-format-precommit)
[![codespell](https://img.shields.io/badge/codespell-enabled-blue)](https://github.com/codespell-project/codespell)
[![markdownlint](https://img.shields.io/badge/markdownlint-enabled-blue)](https://github.com/igorshubovych/markdownlint-cli)
[![shellcheck](https://img.shields.io/badge/shellcheck-enabled-blue)](https://github.com/shellcheck-py/shellcheck-py)

## Features

- Project setup and template update with [copier](https://github.com/copier-org/copier/).
- Containerization for development and deployment with [dev container](https://containers.dev/).
- Continuous Integration with [GitHub Actions](https://docs.github.com/actions).
- Automate dependency updates with [Renovate](https://github.com/renovatebot/renovate).
- Fully featured [vcpkg](https://learn.microsoft.com/en-us/vcpkg/) integration.
  - Supports baseline autoupdate.
  - Supports manifest export mode and build offline.
  - Supports vcpkg port/triplet/toolchain customization.
  - Supports vcpkg triplet auto-detection.
  - Supports vcpkg feature test.
  - Supports auto loads of vcpkg triplet and toolchain variables.
- Build with [cmake](https://cmake.org/documentation/) integration.
  - Provides sorts of cmake `presets`.
  - Provides vcpkg automatic installation or use existing vcpkg installation.
  - Provides `static/runtime analysis`including [clang-tidy](https://clang.llvm.org/extra/clang-tidy/), [cppcheck](http://cppcheck.net/manual.html), [sanitizers](https://clang.llvm.org/docs/index.html), [valgrind](https://valgrind.org/docs/manual/manual.html).
  - Supports `code coverage` with [lcov](https://github.com/linux-test-project/lcov), [gcovr](https://github.com/gcovr/gcovr), llvm-cov, and [opencppcoverage](https://github.com/OpenCppCoverage/OpenCppCoverage).
  - Supports `hardening compilation `for MSVC, Clang, and GCC.
  - Provides compile, header, application target generation.
  - Build with preset build types: Debug, Release, RelWithDebInfo(Default), MinSizeRel.
  - Supports package managers: [vcpkg](https://github.com/microsoft/vcpkg), [conan](https://github.com/conan-io/cmake-conan), and [cpm](https://github.com/cpm-cmake/CPM.cmake).
- Use [cmake-registry](https://github.com/msclock/cmake-registry) to provide various cmake modules and scripts.
- Lint tool `pre-commit` integration with various linters, including [clang-format](https://github.com/pre-commit/mirrors-clang-format), [codespell](https://github.com/codespell-project/codespell), [markdownlint](https://github.com/igorshubovych/markdownlint-cli), and more.
- Handy Makefile for local development.
- Documentation generation with [doxygen](https://www.doxygen.nl/index.html) and [sphinx](https://www.sphinx-doc.org/en/master/) theme [furo](https://github.com/pradyunsg/furo).
- Automatic release workflow with [semantic-release](https://github.com/semantic-release/semantic-release).
- Maintainable [documentation](https://serious-scaffold.github.io/ss-cpp/) guides for configuration, development, security and contribution based on ss-cpp.

## License

MIT License, for more details, see the [LICENSE](https://github.com/serious-scaffold/ss-cpp/blob/master/LICENSE) file.
