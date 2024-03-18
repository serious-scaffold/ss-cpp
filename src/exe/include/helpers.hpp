#pragma once

#include <spdlog/spdlog.h>

namespace exe {
namespace helpers {
inline int some_fun() {
    spdlog::info("Hello helpers!");
    return 0;
}
} // namespace helpers
} // namespace exe
