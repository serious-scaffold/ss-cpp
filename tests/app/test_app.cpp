#include <gtest/gtest.h>
#include "api.hpp"

int main(int argc, char const* argv[]) {
    testing::InitGoogleTest(&argc, const_cast<char**>(argv));
    return RUN_ALL_TESTS();
}

TEST(app_api_info, version) {
    try {
        const auto version = api::info::version_api();
        GTEST_ASSERT_EQ("1.0.0", version);
    }
    catch (const std::exception& e) {
        std::cout << "err:" << e.what() << '\n';
    }
}

TEST(app_api_info, distribution) {
    try {
        const auto is_debug = api::info::is_debug();
#ifdef _DEBUG
        GTEST_ASSERT_TRUE(is_debug);
#else
        GTEST_ASSERT_FALSE(is_debug);
#endif
    }
    catch (const std::exception& e) {
        std::cout << "err:" << e.what() << '\n';
    }
}
