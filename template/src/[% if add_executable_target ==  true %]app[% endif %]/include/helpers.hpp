#pragma once

#include "absl/log/log.h"

inline int some_fun() {
    LOG(INFO) << "Hello "
              << "helpers!";
    return 0;
}
