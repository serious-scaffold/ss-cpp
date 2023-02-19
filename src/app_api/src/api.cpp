#include "api.hpp"
#include <absl/log/log.h>
#include "impl/impl.hpp"

namespace api {
namespace info {
std::string version_api() noexcept {
#ifdef PROJECT_VERSION
    return MACRO_STRINGIFY(PROJECT_VERSION);
#else
    return "dev";
#endif
}

bool api_EXPORT is_debug() noexcept {
    // Using abseil logging library
    LOG_IF(INFO, _DEBUG) << "This is a debug distribution.";
#ifdef _DEBUG
    return true;
#else
    return false;
#endif
}
} // namespace info
} // namespace api
