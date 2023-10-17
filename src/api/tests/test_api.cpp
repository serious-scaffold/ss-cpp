#include <gtest/gtest.h>
#include "api.hpp"
#include "impl/impl.hpp"

TEST(info, version) {
    const auto version = api::info::version_api();
    GTEST_ASSERT_EQ("0.0.0", version);
}

TEST(info, distribution) {
    const auto is_debug = api::info::is_debug();
#ifdef _DEBUG
    GTEST_ASSERT_TRUE(is_debug);
#else
    GTEST_ASSERT_FALSE(is_debug);
#endif
}

TEST(geo, create_rect) {
    const auto drawable = api::geo::CreateRectangleAsDrawable(100, 100);
    GTEST_ASSERT_EQ("shape = {Rectangle: width = 100, height = 100}, area = 10000",
                    api::geo::PrintDrawableToString(drawable));
}
