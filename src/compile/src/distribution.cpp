#include "distribution.hpp"

namespace compile {
namespace distribution {
bool is_debug() noexcept {
#ifdef _DEBUG
    return true;
#else
    return false;
#endif
}
} // namespace distribution
} // namespace compile
