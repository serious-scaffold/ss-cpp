#include <gtest/gtest.h>
#include "compile.hpp"

TEST(info, version) {
    const auto version = compile::info::version_compile();
    EXPECT_FALSE(version.empty());
}

TEST(info, distribution) {
    const auto is_debug = compile::info::is_debug();
#ifdef _DEBUG
    GTEST_ASSERT_TRUE(is_debug);
#else
    GTEST_ASSERT_FALSE(is_debug);
#endif
}
