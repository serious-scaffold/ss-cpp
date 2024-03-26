# Development Environment

This section will guide you through setting up your development environment for the ss-cpp-generated project.

## Prerequisites

Before you begin, you will need to have the following installed on your system:

- A C++ compiler: such as gcc, clang, Apple clang, or msvc (Microsoft Visual C++). See [here](https://en.cppreference.com/w/cpp/compiler_support) for a list of supported features by compiler.
- [CMake](https://cmake.org/): a cross-platform build system.
- Git: a version control system.
- Ninja: a fast build system used by CMake.
- Ccache (optional, but recommended): a compiler cache that can speed up rebuilds.
- Doxygen (optional, but recommended): a cpp source code documentation generator.
- Vcpkg (optional, but recommended): a package manager for C++ libraries.
- Python (optional, but recommended): a scripting language used to generate documentation with sphinx and breathe.
- Coverage tools (optional, but recommended): tools for generating code coverage reports (Html, Lcov, XML).
  - gcovr (for gcc/clang)
  - opencppcoverage (for msvc)
  - lcov (for gcc)
  - llvm-cov (for clang)

Normally, those tools can be installed using package managers like apt(ubuntu), brew(macos), or chocolatey(windows). However, if you are on a fresh system, it's recommended to use setup-cpp to install all of them.

## Setup-cpp

The above prerequisites is a really long list of dependencies, and it's easy to mess up. Fortunately, we have setup-cpp that is a cross-platform tool that will automatically install all of these dependencies for you. See the [setup-cpp documentation](https://github.com/aminya/setup-cpp).

An example that installs llvm, cmake, ninja, ccache, and vcpkg:

```bash
# windows example (open PowerShell as admin)
curl -LJO "https://github.com/aminya/setup-cpp/releases/download/v0.37.0/setup-cpp-x64-windows.exe"
./setup-cpp-x64-windows --compiler llvm --cmake true --ninja true --ccache true --vcpkg true

RefreshEnv.cmd # activate cpp environment variables
```

```bash
# linux example
wget "https://github.com/aminya/setup-cpp/releases/download/v0.37.0/setup-cpp-x64-linux"
chmod +x ./setup-cpp-x64-linux
sudo ./setup-cpp-x64-linux --compiler llvm --cmake true --ninja true --ccache true --vcpkg true

source ~/.cpprc # activate cpp environment variables
```

## Devcontainer for quick start

If you are using Visual Studio Code, you can use the devcontainer feature to quickly get started with the project. This will create a container with all the necessary tools and dependencies pre-installed, and you can start coding immediately. See the [devcontainer documentation](https://code.visualstudio.com/docs/remote/containers) for more information.

To use the devcontainer, you will need to have Docker installed on your system. Then, you can open the project in Visual Studio Code and click on the "Reopen in Container" button in the bottom left corner. This will download the container image and start a new container with necessary tools and dependencies pre-installed.
