#include <gtest/gtest.h>
#include "distribution.hpp"
#include "git.h"

TEST(exe, version) {
    const auto version = git_ProjectVersion();
    EXPECT_STRNE(version, "");
}

TEST(exe, distribution) {
    const auto is_debug = exe::distribution::is_debug();
#ifdef _DEBUG
    EXPECT_TRUE(is_debug);
#else
    EXPECT_FALSE(is_debug);
#endif
}
