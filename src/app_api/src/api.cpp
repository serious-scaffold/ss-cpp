#include "api.hpp"
#include <absl/log/log.h>
#include "impl/impl.hpp"

namespace api {
namespace info {
std::string version_api() noexcept {
    // Using abseil logging library
    LOG_IF(INFO, is_debug()) << "This is a debug distribution.";
#ifdef PROJECT_VERSION
    return MACRO_STRINGIFY(PROJECT_VERSION);
#else
    return "dev";
#endif
}

bool api_EXPORT is_debug() noexcept {
    LOG(INFO) << "This is a debug build.";
#ifdef _DEBUG
    return true;
#else

    return false;
#endif
}
} // namespace info
} // namespace api
