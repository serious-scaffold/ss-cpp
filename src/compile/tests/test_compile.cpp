#include "catch.hpp"

#include "compile.hpp"

TEST_CASE("compile_version", "[compile]") {
    REQUIRE(!compile::ProjectVersion().empty());
}

TEST_CASE("compile_distribution", "[compile]") {
    const auto is_debug = compile::distribution::is_debug();
#ifdef _DEBUG
    REQUIRE(is_debug == true);
#else
    REQUIRE(is_debug == false);
#endif
}
