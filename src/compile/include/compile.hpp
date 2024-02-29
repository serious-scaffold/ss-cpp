#pragma once

#include <string>
#include "compile_export.hpp"

namespace compile {
namespace info {
/**
 * \brief Get compile version string
 * \return The distribution compile version provided.
 */
std::string_view COMPILE_EXPORT version_compile() noexcept;

/**
 * \return A bool represents if it is debug distribution.
 */
bool COMPILE_EXPORT is_debug() noexcept;
}; // namespace info
}; // namespace compile
