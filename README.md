
# CPP Project Blueprint

---
## Dev project features
- Customizable container development environment(vscode dev container).
- `Googletest` integration.
- `Vcpkg` integration.
- Standard dev source layout based on cmake.
- Lint tool `pre-commit` integration.
- Sphinx integration as the sync docs tool.


## CMake integration

CMake common workflow command.

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

todo : https://devblogs.microsoft.com/cppblog/using-multi-stage-containers-for-c-development/
