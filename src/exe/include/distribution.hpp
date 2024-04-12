#pragma once

#include <spdlog/spdlog.h>

namespace exe {
namespace distribution {
inline bool is_debug() noexcept {
#ifdef _DEBUG
    return true;
#else
    return false;
#endif
}
} // namespace distribution
} // namespace exe
