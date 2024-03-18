#include <spdlog/spdlog.h>

#include "git.h"
#include "helpers.hpp"

int main() {
    spdlog::info("Get a returned value: {} ; Version: {}", exe::helpers::some_fun(), git::ProjectVersion());
    return 0;
}
