# Create the compile command database for clang by default
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Always build with -fPIC
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Put the include dirs which are in the source or build tree before all other
# include dirs, so the headers in the sources are preferred over the already
# installed ones since cmake 2.4.1
set(CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE ON)

# Open FetchContent fetching logs.
set(FETCHCONTENT_QUIET OFF)

# This will cause all libraries to be built shared unless the library was
# explicitly added as a static library.  This variable is often added to
# projects as an ``option()`` so that each user of a project can decide if they
# want to build the project using shared or static libraries.
set(BUILD_SHARED_LIBS OFF)

# Enable installation of googletest. (Projects embedding googletest may want to
# turn this OFF.)
set(INSTALL_GTEST OFF)
