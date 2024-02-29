#pragma once

#include <string>
#include "compile_export.hpp"
#include "proxy/proxy.h"

#define STRINGIFY(x)       #x
#define MACRO_STRINGIFY(x) STRINGIFY(x)

namespace compile {
namespace geo {

// proxy-runtime-polymorphism,see
// https://github.com/microsoft/proxy
// https://devblogs.microsoft.com/cppblog/proxy-runtime-polymorphism-made-easier-than-ever/

// Abstraction Draw interface for polymorphic call
struct COMPILE_EXPORT Draw : pro::dispatch<void(std::ostream&)> {
public:
    template <class T>
    void operator()(const T& self, std::ostream& out) {
        self.Draw(out);
    }
};

// Abstraction Area interface for polymorphic call
struct COMPILE_EXPORT Area : pro::dispatch<double()> {
public:
    template <class T>
    double operator()(const T& self) {
        return self.Area();
    }
};

// Interface facade for Draw, Area
struct COMPILE_EXPORT DrawableFacade : pro::facade<Draw, Area> {};

// Client API - Consumer
std::string COMPILE_EXPORT PrintDrawableToString(const pro::proxy<DrawableFacade>& p);

// Client API - Producer
pro::proxy<DrawableFacade> COMPILE_EXPORT CreateRectangleAsDrawable(int width, int height);

}; // namespace geo
}; // namespace compile
