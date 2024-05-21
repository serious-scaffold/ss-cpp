#include "gtest/gtest.h"

#include "compile.hpp"

TEST(compile, version) {
    const auto* const version = git_ProjectVersion();
    EXPECT_STRNE(version, "");
}

TEST(compile, distribution) {
    const auto is_debug = compile::distribution::is_debug();
#ifdef _DEBUG
    EXPECT_TRUE(is_debug);
#else
    EXPECT_FALSE(is_debug);
#endif
}
