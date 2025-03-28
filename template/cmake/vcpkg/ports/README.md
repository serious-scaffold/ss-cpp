# Customize vcpkg ports

This folder applies to the custom vcpkg ports. These ports are loaded automatically which can be patched from the `ports` folder of the vcpkg repository or created from scratch.

## Customize linkage

Prepare the port from the vcpkg repository

```bash
cp /path/to/vcpkg/repository/ports/7zip . -r
```

Edit the port to only accept the dynamic linkage by [vcpkg_check_linkage](https://learn.microsoft.com/en-us/vcpkg/maintainers/functions/vcpkg_check_linkage) to the head of the port file

```bash
sed -i '1s/^/vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)\n/' 7zip/portfile.cmake
```

And re-cmake the project to re-build the port with dynamic linkage.
