#ifndef UTILS__VECTOR_MAKE_UNIQUE_HPP
#define UTILS__VECTOR_MAKE_UNIQUE_HPP

#include <vector>
#include <algorithm> // for std::sort(), std::unique()

namespace utils {

// via: https://stackoverflow.com/a/1041939/
template <typename T>
void make_unique(std::vector<T>& vec)
{
    std::sort(vec.begin(), vec.end());
    vec.erase( std::unique(vec.begin(), vec.end()) , vec.end());
}

} // namespace utils

#endif // UTILS__VECTOR_MAKE_UNIQUE_HPP
