import compile_module;

#include <gtest/gtest.h>
#include "_version.hpp"

#ifdef _DEBUG
#define DIST_FLAG 1
#else
#define DIST_FLAG 0
#endif

TEST(compile_module, version) {
    const auto* const version = git_ProjectVersion();
    EXPECT_STRNE(version, "");
}

TEST(compile_module, distribution) {
    const auto is_debug = compile_module::distribution::is_debug();
    EXPECT_EQ(is_debug, DIST_FLAG);
}
