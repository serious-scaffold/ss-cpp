#pragma once

#include <string>
#include "api_export.hpp"

namespace api {
namespace info {
/**
 * \brief Get api version string
 * \return The distribution api version provided.
 * \note A string "dev" will be returned when no version configuration.
 */
std::string_view api_EXPORT version_api() noexcept;

/**
 * \return A bool represents if debug when building.
 */
bool api_EXPORT is_debug() noexcept;
}; // namespace info
}; // namespace api
