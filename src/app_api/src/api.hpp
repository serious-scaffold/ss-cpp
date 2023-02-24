#pragma once

#include <string>
#include "api_export.hpp"

namespace api {
namespace info {
/**
 * \brief get api version string
 * \note a string "dev" will be returned when no version configuration.
 * \return the distribution api version provided.
 */
std::string api_EXPORT version_api() noexcept;

/**
 * \return a bool represents if debug when building.
 */
bool api_EXPORT is_debug() noexcept;
}; // namespace info
}; // namespace api
