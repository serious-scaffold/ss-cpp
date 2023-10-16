#pragma once

#include "absl/log/log.h"

namespace header {
namespace common {
inline int some_fun() {
    return 0;
}

constexpr int some_constexpr_fun() {
    return 0;
}

const std::string_view const_string() {
    LOG(INFO) << "Calling " << __FUNCTION__;
    return "This is a header only const string";
}
} // namespace common

} // namespace header
