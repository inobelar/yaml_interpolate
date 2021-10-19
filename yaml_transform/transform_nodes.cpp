#include "transform_nodes.hpp"

#include <cassert>

void transform_nodes(const YAML::Node &root_node, YAML::Node &node, const transform_func_t &transform_func)
{
    assert(!root_node.is(node)); // Make sure we dont transform itself :)

    switch (node.Type()) {
    case YAML::NodeType::value::Undefined: break;
    case YAML::NodeType::value::Null:      break;
    case YAML::NodeType::value::Scalar: // <-- Recursion stop
    {
        // Note: scalars - not only 'numbers', but 'non-container' data-types

        std::string scalar = node.Scalar();

        transform_func(root_node, scalar);

        node = scalar;
    } break;
    case YAML::NodeType::value::Sequence: // <-- Recursive visiting
    {
        for(auto&& seq_node : node) // via: https://stackoverflow.com/questions/48568328/yaml-cpp-parsing-nested-maps-and-sequences-error#comment86492560_48575322
        {
            transform_nodes(root_node, seq_node, transform_func);
        }
    } break;
    case YAML::NodeType::value::Map: // <-- Recursive visiting
    {
        for(YAML::iterator it = node.begin(); it != node.end(); ++it)
        {
            // YAML::Node& key_node = it->first;
            YAML::Node& value_node  = it->second;
            transform_nodes(root_node, value_node, transform_func);
        }
    } break;
    default: break;
    }
}

YAML::Node transform_nodes_clone(const YAML::Node &root_node, const transform_func_t &transform_func)
{
    YAML::Node transformed = YAML::Clone(root_node);
    transform_nodes(root_node, transformed, transform_func);
    return transformed;
}
