#include <gtest/gtest.h>
#include "header/header.hpp"

TEST(common, some_fun) {
    const auto fun_ret = header::common::some_fun();
    GTEST_ASSERT_EQ(0, fun_ret);
}

TEST(common, const_string) {
    const auto fun_ret = header::common::const_string();
    GTEST_ASSERT_GT(fun_ret.size(), 0);
}
