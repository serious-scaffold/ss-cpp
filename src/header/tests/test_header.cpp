#include "catch.hpp"

#include "header/header.hpp"

TEST_CASE("header_version", "[header]") {
    REQUIRE(!header::ProjectVersion().empty());
}
