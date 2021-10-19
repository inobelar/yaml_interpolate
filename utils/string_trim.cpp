#include "string_trim.hpp"

#include <cctype>    // for std::isspace
#include <algorithm> // for std::find_if

void utils::str::ltrim(std::string &s) {
    s.erase(s.begin(), std::find_if(s.begin(), s.end(), [](int ch) {
        return !std::isspace(ch);
    }));
}

void utils::str::rtrim(std::string &s) {
    s.erase(std::find_if(s.rbegin(), s.rend(), [](int ch) {
        return !std::isspace(ch);
    }).base(), s.end());
}

void utils::str::trim(std::string &s) {
    ltrim(s);
    rtrim(s);
}

std::string utils::str::ltrim_copy(std::string s) {
    ltrim(s);
    return s;
}

std::string utils::str::rtrim_copy(std::string s) {
    rtrim(s);
    return s;
}

std::string utils::str::trim_copy(std::string s) {
    trim(s);
    return s;
}
