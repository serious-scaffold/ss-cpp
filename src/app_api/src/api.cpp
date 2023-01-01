#include "api.hpp"
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
#ifdef _DEBUG
    return true;
#else
    return false;
#endif
}
} // namespace info
} // namespace api
