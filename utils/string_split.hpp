#ifndef UTILS__STRING_SPLIT_HPP
#define UTILS__STRING_SPLIT_HPP

#include <string>
#include <vector>

namespace utils {
namespace str {

// via: https://stackoverflow.com/a/44155621/
std::vector<std::string> split(const std::string& s, const std::string& delimiter, const bool& removeEmptyEntries = false);

} // namespace str
} // namespace utils

#endif // UTILS__STRING_SPLIT_HPP
