# Hardening

This section will cover various hardening compilation options that can be used to build reliable secure programs.

We adopts the hardening compilation options recommended referred to in the following resources:

- <https://best.openssf.org/Compiler-Hardening-Guides/Compiler-Options-Hardening-Guide-for-C-and-C++.html>
- <https://learn.microsoft.com/en-us/cpp/code-quality/build-reliable-secure-programs?view=msvc-170>


## Hardening Options

Hardening options can be customized based on your specific needs with the below cmake options:

- `USE_HARDENING_FLAGS`: Enables hardening compiler options.
- `USE_HARDENING_LINKS`: Enables hardening linker options.

```{note}
All given options will be checked and applied only if the compiler supports them. Otherwise, the options will be ignored.
```

Here are the hardening options defautlly used in the ss-cpp project.

### MSVC

#### USE_HARDENING_FLAGS

- `/sdl`: Enable additional security checks.
- `/guard:cf`: Enable CFG (Control Flow Guard).
- `/NXCOMPAT`: Data Execution Prevention.
- `/DYNAMICBASE`: Image Randomization.
- `/CETCOMPAT`: Enhanced Mitigation Experience Toolkit (EMET).

#### USE_HARDENING_LINKS

- `/NXCOMPAT`: Data Execution Prevention.
- `/CETCOMPAT`: Enhanced Mitigation Experience Toolkit (EMET).

### GCC/Clang

#### USE_HARDENING_FLAGS

- `-D_GLIBCXX_ASSERTIONS`: Enable assertions.
- `-U_FORTIFY_SOURCE`: Disable stack protector.
- `-D_FORTIFY_SOURCE=3`: Enable stack protector.
- `-fstack-protector-strong`: Enable stack protector.
- `-fcf-protection`: Control Flow Guard.
- `-fstack-clash-protection`: Control Flow Guard.
- `-Wimplicit-fallthrough`: Enabled in compiler flags by default.
- `-fstrict-flex-arrays=3`: Enable strict array bounds.
- `-Wformat`: Enabled in compiler flags by default.
- `-Wformat=2`: Enabled in compiler flags by default.
- `-Wl,-z,nodlopen`: Restrict dlopen(3) calls to shared objects.
- `-Wl,-z,noexecstack`: Enable data execution prevention by marking stack memory as non-executable.
- `-Wl,-z,relro`: Mark relocation table entries resolved at load-time as read-only.
- `-Wl,-z,now`: Mark relocation table entries resolved at load-time as read-only. It impacts startup performance.
- `-fsanitize=undefined -fsanitize-minimal-runtime`: Enable minimal runtime undefined behavior sanitizer.
- `-fno-delete-null-pointer-checks`
- `-fno-strict-overflow`
- `-fno-strict-aliasing`
- `-ftrivial-auto-var-init=zero`
- `-Wtrampolines`: Enable trampolines(gcc only).
- `-mbranch-protection=standard`: Enable indirect branches(aarch64 only).

#### USE_HARDENING_LINKS

- `-fstack-protector-strong`: Enable stack protector.
- `-Wl,-z,nodlopen`: Restrict dlopen(3) calls to shared objects.
- `-Wl,-z,noexecstack`: Enable data execution prevention by marking stack memory as non-executable.
- `-Wl,-z,relro`: Mark relocation table entries resolved at load-time as read-only.
- `-Wl,-z,now`: Mark relocation table entries resolved at load-time as read-only. It impacts startup performance.
- `-fsanitize=undefined -fsanitize-minimal-runtime`: Enable minimal runtime undefined behavior sanitizer.
