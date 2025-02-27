# Customize vcpkg triplets

This folder applies to the custom vcpkg triplets. These triplets are loaded automatically which can be copied from the `triplets` folder of the vcpkg repository or created from scratch.

## Customize linkage

Prepare the triplet from the vcpkg repository

```bash
cp /path/to/vcpkg/repository/triplets/x64-linux.cmake ./x64-linux.cmake
```

Edit the triplet to change the [VCPKG_LIBRARY_LINKAGE](https://learn.microsoft.com/en-us/vcpkg/users/triplets) to dynamic

```bash
# Apply for all ports to link dynamically
sed -i ./x64-linux.cmake -e's/set(VCPKG_LIBRARY_LINKAGE static)/set(VCPKG_LIBRARY_LINKAGE dynamic)/g'

# Or apply for specific ports to link dynamically
cat << EOF >> ./x64-linux.cmake
if(PORT MATCHES "qt5-")
    set(VCPKG_LIBRARY_LINKAGE dynamic)
endif()
EOF
```

Use it when configure the project

```bash
#  Use it when configure the project
cmake ... -DVCPKG_TARGET_TRIPLET=x64-linux
```
