#include "api.hpp"
#include <absl/log/log.h>
#include "git.h"
#include "impl/impl.hpp"

namespace api {
namespace info {
std::string_view version_api() noexcept {
    return git::ProjectVersion();
}

bool api_EXPORT is_debug() noexcept {
#ifdef _DEBUG
    return true;
#else
    return false;
#endif
}

} // namespace info
} // namespace api
