#include "transform_with_regexp.hpp"

#include "utils/string_trim.hpp"
#include "utils/string_split.hpp"

#include "utils/failure_mesage.hpp"

void transform_with_regexp(
        const YAML::Node &root_node,
        std::string &str,
        const RegexpWithPattern& rgx,
        const std::string &separator)
{
    std::smatch matches;

    // Text may contain multiple insertions, or insertion may be nested.
    // That's why we parse text in a cycle
    while( std::regex_search(str, matches, rgx.getRegexp()) ) // Match found
    {
        // Regular expression not contains at least single capture group
        // (at index 1) --> contains only match result (at index 0).
        if(matches.size() <= 1)
        {
            failure_message(3, "<!> Regexp \'%s\' don't have capture group\n", rgx.getPattern().c_str());
        }

        const auto& match = matches[1]; // 0 - pattern, 1 - capture group
        std::string text_between_brackets = match.str();

        utils::str::trim(text_between_brackets); // Trim: erase empty space before & after text

        // Split by 'separator' with 'Keeping empty parts' - to handle misspelling/type-errors
        const auto tokens = utils::str::split(text_between_brackets, separator, false);

        // used stack here, since YAML::Node::operator [] returns 'const YAML::Node', instead of ptr/reference. So we must put them in a stack
        std::vector<YAML::Node> nodes_stack { root_node };
        bool node_found = false;

        for(const std::string& token : tokens)
        {
            const YAML::Node node_for_token = nodes_stack.back()[token];
            if(node_for_token) {
                nodes_stack.push_back(node_for_token);
                node_found = true;
            } else {
                node_found = false;
                break;
            }
        }

        if( node_found )
        {
            const std::string& result = nodes_stack.back().Scalar();

            // Replace 'matched text' in 'str' by found node text
            str.replace(matches.position(), matches.length(), result);
        } else {
            // Error: cannot found 'tokens' path
            failure_message(3, "<!> Cannot find token at: \'%s\'\n", text_between_brackets.c_str());
        }
    }
}
