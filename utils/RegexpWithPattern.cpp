#include "RegexpWithPattern.hpp"

RegexpWithPattern::RegexpWithPattern(const std::string &pattern)
    : _pattern(pattern)
{
    try
    {
        _regexp = std::regex(pattern);

        _is_valid = true;
    }
    catch(const std::regex_error& exp)
    {
        _is_valid = false;
        _error_str = exp.what();
    }
}

const std::string &RegexpWithPattern::getPattern() const
{
    return _pattern;
}

const std::regex &RegexpWithPattern::getRegexp() const
{
    return _regexp;
}

bool RegexpWithPattern::isValid() const
{
    return _is_valid;
}

const std::string &RegexpWithPattern::getErrorStr() const
{
    return _error_str;
}
