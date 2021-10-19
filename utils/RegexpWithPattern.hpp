#ifndef REGEXP_WITH_PATTERN_HPP
#define REGEXP_WITH_PATTERN_HPP

#include <regex>
#include <string>

/*
    Inspired by:
        - https://stackoverflow.com/questions/30990841/extracting-original-regex-pattern-from-stdregex
        - https://stackoverflow.com/questions/61568019/c-check-if-string-is-valid-regex-string-without-exception
*/

class RegexpWithPattern
{
    std::string _pattern;
    std::regex  _regexp;

    bool        _is_valid;
    std::string _error_str;

public:

    RegexpWithPattern(const std::string& pattern);

    const std::string& getPattern() const;
    const std::regex&  getRegexp() const;

    bool isValid() const;
    const std::string& getErrorStr() const;
};

#endif // REGEXP_WITH_PATTERN_HPP
