#include <gtest/gtest.h>
#include "impl/impl.hpp"

TEST(geo, create_rect) {
    const auto drawable = compile::geo::CreateRectangleAsDrawable(100, 100);
    GTEST_ASSERT_EQ("shape = {Rectangle: width = 100, height = 100}, area = 10000",
                    compile::geo::PrintDrawableToString(drawable));
}
