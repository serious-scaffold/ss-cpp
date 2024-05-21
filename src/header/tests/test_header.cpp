#include <gtest/gtest.h>
#include "header/header.hpp"

TEST(header, version) {
    const auto version = git_ProjectVersion();
    EXPECT_STRNE(version, "");
}
