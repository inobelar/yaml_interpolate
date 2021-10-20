#include <iostream> // for std::cout
#include <fstream>  // for std::ofstream

#include <cxxopts.hpp>
#include <yaml-cpp/yaml.h>

#include "yaml_transform/transform_nodes.hpp"
#include "yaml_transform/transform_with_regexp.hpp"

#include "utils/vector_make_unique.hpp"
#include "utils/failure_mesage.hpp"

/*
    via: https://stackoverflow.com/a/12586201/
    alternatives: https://www.google.com/search?q=regex+between+curly+brackets

    Test cases:
        - Input: {text1}, {{text2}},  {{  text3   }}, {{ \} }}, {{  text4 \}\} }}
        - Ouput: "text2", "  text3   ", " \} ", "  text \}\} "
*/
static const RegexpWithPattern RGX_MOUSTACHE(R"(\{\{(.*?)\}\})");

static const RegexpWithPattern RGX_DOUBLE_DOLLAR(R"(\$(\S+)\$)");
static const RegexpWithPattern RGX_DOUBLE_PERCENT(R"(\%(\S+)\%)");

int main(int argc, const char* argv[])
{
    std::string input_file_path;
    std::string output_file_path = "stdout";

    std::string separator = ".";

    std::vector<std::string> formats;
    std::vector<std::string> regexps;

    // -------------------------------------------------------------------------
    // Parse command-line options

    try
    {
        cxxopts::Options options(argv[0], "");

        // Options output settings
        options
            .show_positional_help()
            .set_width(80)
            .set_tab_expansion();

        options.add_options("I/O")
            ("i,input",
                "Input yaml file path (or 'stdin'). (required)",
                cxxopts::value<std::string>(),
                "PATH")
            ("o,output",
                "Output file name (or 'stdout')",
                cxxopts::value<std::string>()
                    ->default_value(output_file_path),
                "PATH"
            );

        options.add_options("Parsing settings")
            ("formats",
                  "Formats:\n"
                  "moustache:      {{ variable.path }}\n"
                  "double_dollar:  $variable.path$\n"
                  "double_percent: %variable.path%\n",
                cxxopts::value<std::vector<std::string>>()
                    ->default_value("moustache"),
                "LIST"
            )
            ("separator",
               "Separator between node names",
               cxxopts::value<std::string>()->default_value(separator),
               "STRING"
            )
            ("regexps",
               "Regular expressions to find pattern\n"
               "Notice, that them must contain single capture group",
               cxxopts::value< std::vector<std::string> >(),
               "LIST"
            );

        options.add_options("Help")
            ("help", "Print this help");

        const auto result = options.parse(argc, argv);

        // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        if(result.count("help"))
        {
            std::puts( options.help({"I/O", "Parsing settings", "Help"}).c_str() );
            exit(0);
        }

        if(result.count("input")) // <-- Required
        {
            input_file_path = result["input"].as<std::string>();
        }
        else // No input file path specified
        {
            failure_message(1, "%s\n", "<!> No input file path specified!");
        }

        if(result.count("output"))
        {
            output_file_path = result["output"].as<std::string>();
        }

        if(result.count("formats"))
        {
            formats = result["formats"].as<std::vector<std::string>>();
            utils::make_unique(formats);
        }
        else
        {
            /*
                This branch is needed, since, unexpectedly the next code:
                    cxxopts::value<std::vector<std::string>>()
                        ->default_value("moustache"),
                not generates at least single-item array of "moustache", in case
                when user not specify this option. So we simply, assign default
                value manually.

                Well... Looking for cxxopts test, I found, that in case of
                'default_value' specified, we dont need to check it by calling
                'count()', but simply get 'result["option"]' directly. But this
                is strange, so here is check-and-manual-set.
            */

            formats = {"moustache"};
        }

        if(result.count("separator"))
        {
            separator = result["separator"].as<std::string>();
        }

        if(result.count("regexps"))
        {
            regexps = result["regexps"].as<std::vector<std::string>>();
            utils::make_unique(regexps);
        }

    }
    catch (const cxxopts::OptionException& e)
    {
        failure_message(1, "<!> Error parsing options: %s\n", e.what());
    }

    // -------------------------------------------------------------------------
    // Making transform functions

    std::map<std::string, transform_func_t> transforms;

    for(const std::string& format : formats)
    {
        transform_func_t func = nullptr;

        if(format == "moustache")
        {
            func = [separator](const YAML::Node& root_node, std::string& str) {
                transform_with_regexp(root_node, str, RGX_MOUSTACHE, separator);
            };
        }
        else if(format == "double_dollar")
        {
            func = [separator](const YAML::Node& root_node, std::string& str) {
                transform_with_regexp(root_node, str, RGX_DOUBLE_DOLLAR, separator);
            };
        }
        else if(format == "double_percent")
        {
            func = [separator](const YAML::Node& root_node, std::string& str) {
                transform_with_regexp(root_node, str, RGX_DOUBLE_PERCENT, separator);
            };
        }
        else
        {
            failure_message(1, "<!> Unsupported format: \'%s\'\n", format.c_str());
        }

        transforms.insert({format, func});
    }

    for(const std::string& regexp : regexps)
    {
        const RegexpWithPattern rgx(regexp);

        if(!rgx.isValid())
        {
            failure_message(1, "<!> Regular expression invalid: %s\n", rgx.getPattern().c_str());
        }

        transform_func_t func = [rgx, separator](const YAML::Node& root_node, std::string& str)
        {
            transform_with_regexp(root_node, str, rgx, separator);
        };

        transforms.insert({regexp, func});
    }

    if(transforms.empty())
    {
        failure_message(1, "%s\n", "<!> No formats and regexps specified");
    }

    // -------------------------------------------------------------------------
    // Transforming YAML file & output

    try
    {
        const YAML::Node config =
                (input_file_path == "stdin")
                ?
                    YAML::Load(std::cin)
                :
                    YAML::LoadFile(input_file_path);

        // ---------------------------------------------------------------------

        // Transform multiple times - on each pass called specific transform func
        YAML::Node transformed = config; // no need to `YAML::Clone(config);` here
        for(const auto& kv: transforms)
        {
            transformed = transform_nodes_clone(transformed, kv.second);
        }
        /*
            // Alternate (non-working) code, with single 'clone'. Dont works in
            // cases with multiple transform patterns in single line.
            YAML::Node transformed = YAML::Clone(config);
            for(const auto& kv: transforms)
            {
                transform_nodes(config, transformed, kv.second);
            }
         */

        // ---------------------------------------------------------------------


        if(output_file_path.empty() || (output_file_path == "stdout")) // Output to stdout
        {
            std::cout << transformed << std::endl; // With extra trailing new-line
        }
        else // Output to file
        {
            std::ofstream fout(output_file_path);
            if(fout.is_open())
            {
                YAML::Emitter emitter;
                emitter << transformed;

                fout << emitter.c_str();

                fout.close();
            }
            else
            {
                failure_message(2, "<!> Could not open file: %s\n", output_file_path.c_str());
            }
        }

    }
    catch (const YAML::Exception& e)
    {
        failure_message(2, "<!> YAML error: %s\n", e.what());
    }

    return 0;
}
