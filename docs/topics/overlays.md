# Overlays

Overlays enable the vcpkg overlay feature, which allows user to customize the build triplets and ports of vcpkg.

## Overlay of a custom triplet

> According to [the official documentation](https://learn.microsoft.com/en-us/vcpkg/users/examples/overlay-triplets-linux-dynamic), to add a custom [triplet](https://learn.microsoft.com/en-us/vcpkg/concepts/triplets), create a new directory and copy the `triplets` directory from the vcpkg installation directory to the new directory. Then, create a `triplet` file in the new directory and modify the `CMAKE_SYSTEM_NAME` and `VCPKG_TARGET_ARCHITECTURE` variables to match your custom triplet. Finally, add the new directory to the `overlay-triplets` list in the `vcpkg.json` file.

The scaffold designed for this purpose, we create a new directory `cmake/vcpkg/triplets` in the root of our scaffold which has been registered as an overaly-triplets in `vcpkg.json`. Inside this directory, what we need to do is create a new triplet file according to the triplet naming convention `CPU-OS/compiler-runtime.cmake`(Triplet is a standard term used in cross-compiling as a way to completely capture the target environment in a single, convenient name) for example, `x64-linux-dynamic.cmake` or `arm64-windows-static.cmake`. Or we can copy an existing triplet file from the vcpkg root directory and modify it according to our needs.

References:

- <https://learn.microsoft.com/en-us/vcpkg/users/examples/overlay-triplets-linux-dynamic>
- [Why overlay triplets? Per port customization](https://learn.microsoft.com/en-us/vcpkg/users/triplets#per-port-customization)

## Overlay of a custom port

> A port based on vcpkg is a set of files that can be used to build a library or an executable.

There are two ways to add a custom port to vcpkg:

- Create a vcpkg registry repository and add the port to it. The repository can be added to the `registries` list in the `vcpkg.json` file. That's the way the cmake-registry registry in the scaffold is implemented.
- Add a port to the `overlay-ports` directory of the project which can be used to register the port in the `vcpkg.json` file. Actually, this is doing the same thing as the overlay triplets and the way in which the `cmake/vcpkg/ports` directory in the scaffold also is implemented. See also the vcpkg official documentation on [overlay-ports](https://learn.microsoft.com/en-us/vcpkg/concepts/overlay-ports).

References:

- <https://learn.microsoft.com/en-us/vcpkg/concepts/overlay-ports>
- [Why overlay ports? Install locally modified package](https://learn.microsoft.com/en-us/vcpkg/consume/install-locally-modified-package)

## Overlay of a custom chinaload toolchain

>  a toolchain file is selected from `scripts/toolchains/` appropriate to the platform by default.

To use a custom chianload toolchain, a directory `cmake/vcpkg/scripts/toolchains` has been created in the root of the scaffold.

References:

- [What is a chinaload toolchain in vcpkg?](https://learn.microsoft.com/en-us/vcpkg/users/triplets#vcpkg_chainload_toolchain_file)
