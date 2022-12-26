#pragma once

#include <string>
#include "api_export.hpp"

namespace api {
namespace info {
/**
 * @brief
 * get api version string
 *
 * @note 'dev' will be returned when no version configuration.
 */
std::string api_EXPORT version_api() noexcept;
}; // namespace info
}; // namespace api
