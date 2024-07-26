#include "distribution.hpp"

namespace exe {
namespace distribution {
bool is_debug() noexcept {
#ifdef _DEBUG
    return true;
#else
    return false;
#endif
}
} // namespace distribution
} // namespace exe
