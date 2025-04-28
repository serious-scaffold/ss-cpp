#include "catch.hpp"

#include "_version.hpp"
#include "distribution.hpp"

TEST_CASE("exe_version", "[exe]") {
    REQUIRE(!exe::ProjectVersion().empty());
}

TEST_CASE("exe_distribution", "[exe]") {
    const auto is_debug = exe::distribution::is_debug();
#ifdef _DEBUG
    REQUIRE(is_debug == true);
#else
    REQUIRE(is_debug == false);
#endif
}
