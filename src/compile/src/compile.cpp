#include "compile.hpp"

#include <absl/log/log.h>
#include "git.h"
#include "impl/impl.hpp"

namespace compile {
namespace info {
std::string_view version_compile() noexcept {
    return git::ProjectVersion();
}

bool is_debug() noexcept {
#ifdef _DEBUG
    return true;
#else
    return false;
#endif
}

} // namespace info
} // namespace compile
