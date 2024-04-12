#include <spdlog/spdlog.h>

#include "distribution.hpp"
#include "git.h"

int main() {
    spdlog::info("Build Version: {}", git::ProjectVersion());
    spdlog::info("Distribution Type: {}", exe::distribution::is_debug() ? "Debug" : "Release");
    return 0;
}
