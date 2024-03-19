#include "compile.hpp"

#include "git.h"

namespace compile {
namespace info {
std::string_view version() noexcept {
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
