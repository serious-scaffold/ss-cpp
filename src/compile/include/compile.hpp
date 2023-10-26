#pragma once

#include <string>
#include "compile_export.hpp"

namespace compile {
namespace info {
/**
 * \brief Get compile version string
 * \return The distribution compile version provided.
 * \note A string "dev" will be returned when no version configuration.
 */
std::string_view compile_EXPORT version_compile() noexcept;

/**
 * \return A bool represents if debug when building.
 */
bool compile_EXPORT is_debug() noexcept;
}; // namespace info
}; // namespace compile
