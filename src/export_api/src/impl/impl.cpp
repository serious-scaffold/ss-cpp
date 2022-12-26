#include "impl/impl.hpp"
#include <sstream>

namespace api {
// Implementation (No base class)
class Rectangle {
public:
    void Draw(std::ostream& out) const { out << "{Rectangle: width = " << width_ << ", height = " << height_ << "}"; }
    void SetWidth(double width) { width_ = width; }
    void SetHeight(double height) { height_ = height; }
    double Area() const { return width_ * height_; }

private:
    double width_;
    double height_;
};
namespace geo {

std::string PrintDrawableToString(pro::proxy<DrawableF> p) {
    std::stringstream result;
    result << "shape = ";
    p.invoke<Draw>(result);                    // Polymorphic call
    result << ", area = " << p.invoke<Area>(); // Polymorphic call
    return std::move(result).str();
}

pro::proxy<DrawableF> CreateRectangleAsDrawable(int width, int height) {
    Rectangle rect;
    rect.SetWidth(width);
    rect.SetHeight(height);
    return pro::make_proxy<DrawableF>(rect); // No heap allocation is expected
}
} // namespace geo
} // namespace api