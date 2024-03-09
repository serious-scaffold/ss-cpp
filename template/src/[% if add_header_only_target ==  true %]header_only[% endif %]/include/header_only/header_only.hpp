#pragma once

#include <spdlog/spdlog.h>
#include "git.h"

namespace header_only {
namespace common {
inline int some_fun() {
    spdlog::info("{}", git::ProjectVersion());
    return 0;
}

const std::string_view const_string() {
    spdlog::info("Calling {}", __FUNCTION__);
    return "This is a header_only only const string";
}
} // namespace common

} // namespace header_only
