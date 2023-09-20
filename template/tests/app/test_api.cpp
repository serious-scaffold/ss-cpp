#include <gtest/gtest.h>
#include "api.hpp"
#include "impl/impl.hpp"

// Main function can be ignored with configuration in test CMakeLists.txt:
//  include(GoogleTest)
//  gtest_discover_tests
// int main(int argc, char const* argv[]) {
//     testing::InitGoogleTest(&argc, const_cast<char**>(argv));
//     return RUN_ALL_TESTS();
// }

TEST(app_api_info, version) {
    const auto version = api::info::version_api();
    GTEST_ASSERT_EQ("1.0.0", version);
}

TEST(app_api_info, distribution) {
    const auto is_debug = api::info::is_debug();
#ifdef _DEBUG
    GTEST_ASSERT_TRUE(is_debug);
#else
    GTEST_ASSERT_FALSE(is_debug);
#endif
}

TEST(app_api, create_rect) {
    const auto drawable = api::geo::CreateRectangleAsDrawable(100, 100);
    GTEST_ASSERT_EQ("shape = {Rectangle: width = 100, height = 100}, area = 10000",
                    api::geo::PrintDrawableToString(drawable));
}
