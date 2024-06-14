#include <spdlog/spdlog.h>

#include "_version.hpp"
#include "distribution.hpp"

int main() {
    spdlog::info("Build Version: {}", exe::ProjectVersion());
    spdlog::info("Distribution Type: {}", exe::distribution::is_debug() ? "Debug" : "Release");
    return 0;
}
