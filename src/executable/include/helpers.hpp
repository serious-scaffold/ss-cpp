#pragma once

#include "absl/log/log.h"

namespace executable {
namespace helpers {
inline int some_fun() {
    LOG(INFO) << "Hello "
              << "helpers!";
    return 0;
}
} // namespace helpers
} // namespace executable
