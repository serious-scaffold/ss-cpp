module;

module compile_module;

namespace compile_module {
namespace distribution {
bool is_debug() noexcept {
#ifdef _DEBUG
    return true;
#else
    return false;
#endif
}
} // namespace distribution
} // namespace compile_module
