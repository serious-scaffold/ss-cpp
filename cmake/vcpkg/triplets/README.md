# Customize vcpkg triplets

This folder applies to the custom vcpkg triplets. These triplets are loaded automatically which can be copied from the `triplets` folder of the vcpkg repository or created from scratch.

For example, to create a custom triplet for Linux x64 with dynamic library linkage:

```bash
# Copy the triplet from the vcpkg repository
cp /path/to/vcpkg/repository/triplets/x64-linux.cmake ./x64-linux.cmake
# Edit the triplet to change the library linkage to dynamic
sed -i ./x64-linux.cmake -e's/set(VCPKG_LIBRARY_LINKAGE static)/set(VCPKG_LIBRARY_LINKAGE dynamic)/g'
# Show the contents of the triplet
cat ./x64-linux.cmake
# set(VCPKG_TARGET_ARCHITECTURE x64)
# set(VCPKG_CRT_LINKAGE dynamic)
# set(VCPKG_LIBRARY_LINKAGE dynamic)

# set(VCPKG_CMAKE_SYSTEM_NAME Linux)

#  Use it when configure the project
cmake --preset=default -DVCPKG_TARGET_TRIPLET=x64-linux
```
