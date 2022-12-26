#include <gtest/gtest.h>
#include "api.hpp"
int main(int argc, char const* argv[]) {
    testing::InitGoogleTest(&argc, const_cast<char**>(argv));
    return RUN_ALL_TESTS();
}

TEST(app_374_suit, check_app_374_suit) {
    try {
        GTEST_ASSERT_EQ("1.0.0", api::info::version_api());
    }
    catch (const std::exception& e) {
        std::cout << "err:" << e.what() << '\n';
    }
}
