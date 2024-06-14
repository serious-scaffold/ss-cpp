#include "gtest/gtest.h"

#include "_version.hpp"
#include "distribution.hpp"

TEST(exe, version) {
    const auto* const version = git_ProjectVersion();
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
