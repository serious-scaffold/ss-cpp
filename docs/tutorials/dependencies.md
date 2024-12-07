# Dependencies

This page will guide you through the process of managing dependencies in your C++ project. We will use the `CMake` build system to manage dependencies.

## Dependencies Sources

There are several sources can be used to manage dependencies in your C++ project. Here are available ones:

- System packages (Not recommended): these are installed on your system and can be easily found using `apt-get`, `yum`, `pacman`, etc.
- Vcpkg packages (Recommended): there are many packages available on `vcpkg`.
- Conan packages: there are also packages available on `conan`.
- CPM packages: there are also packages available on `CPM`.


## Using Vcpkg

Vcpkg is a C++ package manager that provides a simple way to install and integrate third-party libraries. It is available for Windows, Linux, and MacOS. It is the default package manager of the generated project. See the following links to learn how to manage dependencies using Vcpkg:

- <https://learn.microsoft.com/en-us/vcpkg/consume/manifest-mode>
- <https://learn.microsoft.com/en-us/vcpkg/consume/lock-package-versions>
- <https://learn.microsoft.com/en-us/vcpkg/consume/install-locally-modified-package>


## Using Conan

Conan is an another C++ package manager integrated with CMake scripts in the generated project.

````{note}

Conan is default disabled in the generated project. To enable it, you need to add `-d use_conan=true` to  the copier command.

```bash
copier copy gh:serious-scaffold/ss-cpp /path/to/project -d use_conan=true
```
````

The above command will generate a cmake module file `cmake/ConfigureConanDependencies.cmake`, which presents an example of how to use Conan to manage dependencies.

```{literalinclude} ../../template/cmake/[% if ss_cmake_use_conan == true %]ConfigureConanDependencies.cmake[% endif %]
:language: cmake
```

## Using CPM

CPM is CMake's missing package manager. A small CMake script for setup-free, cross-platform, reproducible dependency management. And it is also integrated with CMake scripts in the generated project.

````{note}

CPM is default disabled in the generated project. To enable it, you need to add `-d use_cpm=true` to  the copier command.

```bash
copier copy gh:serious-scaffold/ss-cpp /path/to/project -d use_cpm=true
```
````


The above command will generate a cmake module file `cmake/ConfigureCPMDependencies.cmake`, which presents an example of how to use CPM to manage dependencies.


```{literalinclude} ../../template/cmake/[% if ss_cmake_use_cpm == true %]ConfigureCPMDependencies.cmake[% endif %]
:language: cmake
```
