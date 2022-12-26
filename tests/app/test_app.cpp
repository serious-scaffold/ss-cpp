#include <gtest/gtest.h>
#include "api.hpp"

int main(int argc, char const* argv[]) {
    testing::InitGoogleTest(&argc, const_cast<char**>(argv));
    return RUN_ALL_TESTS();
}

TEST(app_374_suit, check_app_374_suit) {
    try {
        const auto version = api::info::version_api();
        GTEST_ASSERT_EQ("1.0.0", version);
    }
    catch (const std::exception& e) {
        std::cout << "err:" << e.what() << '\n';
    }
}
