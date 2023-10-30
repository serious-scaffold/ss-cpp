#include <gtest/gtest.h>
#include "helpers.hpp"

TEST(executable_helpers, some_fun) {
    const auto fun_ret = executable::helpers::some_fun();
    GTEST_ASSERT_EQ(0, fun_ret);
}
