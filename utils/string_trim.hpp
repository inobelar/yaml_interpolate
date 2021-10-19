#ifndef UTILS__STRING_TRIM_HPP
#define UTILS__STRING_TRIM_HPP

#include <string>    // for std::string

namespace utils {
namespace str {
// via: https://stackoverflow.com/a/217605

// trim from start (in place)
void ltrim(std::string &s);

// trim from end (in place)
void rtrim(std::string &s);

// trim from both ends (in place)
void trim(std::string &s);

// trim from start (copying)
std::string ltrim_copy(std::string s);

// trim from end (copying)
std::string rtrim_copy(std::string s);

// trim from both ends (copying)
std::string trim_copy(std::string s);

} // namespace str
} // namespace utils

#endif // UTILS__STRING_TRIM_HPP
