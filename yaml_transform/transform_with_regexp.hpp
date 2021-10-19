#ifndef TRANSFORM_WITH_REGEXP_HPP
#define TRANSFORM_WITH_REGEXP_HPP

#include <yaml-cpp/yaml.h>

#include "utils/RegexpWithPattern.hpp"

void transform_with_regexp(
        const YAML::Node& root_node,
        std::string& str,
        const RegexpWithPattern& rgx,
        const std::string& separator);

#endif // TRANSFORM_WITH_REGEXP_HPP
