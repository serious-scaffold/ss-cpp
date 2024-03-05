# CMake Workflow

## Without Presets

```bash
# Configure
cmake -S . -B build
# Build
cmake --build build --config Debug
# Testing
cd build && ctest -C Debug -T test --output-on-failure
# Memcheck
cd build && ctest -C Debug -T memcheck
# Install
cmake --build build --config Debug --target install
```

## With Presets

```bash
# with presets https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html
cmake -S . --list-presets         # list all configure presets
cmake -S . --preset=<preset>      # configure using desired configure preset
cmake --build --list-presets      # list all build presets
cmake --build --preset=<preset>   # build the desired build preset
ctest --list-presets              # list all test presets
ctest --preset=<preset>           # test the desired test preset
```
