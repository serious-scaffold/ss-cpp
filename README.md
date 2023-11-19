# Serious Scaffold Cpp

A development-focused Cpp project template.

[![GitHub CI Status](https://github.com/serious-scaffold/ss-cpp/actions/workflows/ci.yml/badge.svg)](https://github.com/serious-scaffold/ss-cpp/actions/workflows/ci.yml)
[![GitHub Release](https://img.shields.io/github/v/release/serious-scaffold/ss-cpp)](https://github.com/serious-scaffold/ss-cpp/releases)
[![GitHub License](https://img.shields.io/github/license/serious-scaffold/ss-cpp)](https://github.com/serious-scaffold/ss-cpp/blob/master/LICENSE)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![SS Cpp](https://img.shields.io/badge/Serious%20Scaffold-c++-blue)](https://github.com/serious-scaffold/ss-cpp)

## Features

- Project setup and template update with [copier](https://github.com/copier-org/copier/).
- Customizable container development environment(vscode dev container).
- `Googletest` integration.
- `Vcpkg` integration.
- Standard development source layout based on cmake and configuration cmake presets.
- Manage cmake modules using [cmake-registry](https://github.com/msclock/cmake-registry).
- Lint tool `pre-commit` integration.
- Sphinx integration as the sync docs tool.

## 🚀 Quickstart

1. Generate the project.

   ```bash
   copier copy gh:serious-scaffold/ss-cpp /path/to/project
   ```

2. Navigate to the project directory and initialize a git repository.

   ```bash
   cd /path/to/project
   git init
   ```

3. Commit the initialized project.

   ```bash
   git add .
   git commit -m "Init."
   ```

4. That's it! Feel free to focus on the coding within `src` folder.

## 📜 License

MIT License, for more details, see the [LICENSE](https://github.com/serious-scaffold/ss-cpp/blob/master/LICENSE) file.
