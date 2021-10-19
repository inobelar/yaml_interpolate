#ifndef TRANSFORM_NODES_HPP
#define TRANSFORM_NODES_HPP

#include <yaml-cpp/yaml.h>
#include <functional>

using transform_func_t = std::function<void (const YAML::Node& root_node, std::string& str)>;

void transform_nodes(const YAML::Node& root_node, YAML::Node& node, const transform_func_t& transform_func);

YAML::Node transform_nodes_clone(const YAML::Node& root_node, const transform_func_t& transform_func);

#endif // TRANSFORM_NODES_HPP
