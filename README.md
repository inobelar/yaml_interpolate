# YAML interpolate

`yaml_interpolate` is a command-line tool for doing [string interpolation](https://en.wikipedia.org/wiki/String_interpolation) inside a [YAML](https://yaml.org/) file.

That tool exists, since YAML specification not allow string interploation, only [alieses and anchors](https://yaml.org/YAML_for_ruby.html#aliases_and_anchors).

That tool is designed to process a single YAML file with both *template* and *data* for it. See possible [alternatives](https://stackoverflow.com/questions/15777987/string-interpolation-in-yaml) ([1](https://stackoverflow.com/questions/13055753/passing-variables-inside-rails-internationalization-yml-file), [2](https://stackoverflow.com/questions/13178268/translation-in-yml-with-optional-parameter), [3](https://stackoverflow.com/questions/3141438/can-one-yaml-object-refer-to-another), [4](https://stackoverflow.com/questions/7169121/is-there-a-way-to-reference-a-constant-in-a-yaml-with-rails)) for other cases / other languages.

Written in C++11 (not in python or ruby, for example), since I find it hard to express logic without strong typing :)

## Example of usage

```shell
$ yaml_interpolate --input=input.yaml --output=processed.yaml --formats=moustache
```

```yaml
strings:
    str1: "Hello"
    str2: "world"

# Interpolated value: "Hello, world!"
greeting: "{{strings.str1}}, {{strings.str2}}!"
```

----

### Advanced usage

#### Access by index

```yaml
numbers:
    - 2.71828
    - 6.022e+23
    - value: 3.14

# Interpolated value: "Numbers: [ 2.71828, 6.022e+23, 3.14 ]"
text: "Numbers: [ {{numbers.0}}, {{numbers.1}}, {{numbers.2.value}} ]"
```

#### Multiple formats support:

- Inline form (single `formats` option):
    ```shell
    $ yaml_interpolate --input=input.yaml --output=processed.yaml \
        --formats=moustache,double_dollar,double_percent
    ```
- Multi-option form (multiple `formats` options):
    ```shell
    $ yaml_interpolate --input=input.yaml --output=processed.yaml \
        --formats=moustache \
        --formats=double_dollar \
        --formats=double_percent
    ```

```yaml
strings:
    str1: "Hello"
    str2: "world"

# Interpolated value: "Hello, world!"
greeting1: "{{ strings.str1 }}, {{ strings.str2 }}!" # <-- format: moustache
greeting2: "$strings.str1$, $strings.str2$!"         # <-- format: double_dollar
greeting3: "%strings.str1%, %strings.str2%!"         # <-- format: double_percent

# Interpolated value: "Greetings: Hello, world!, Hello, world!, Hello, world!"
greetings: "Gretings: %greeting1%, $greeting2$, {{greeting3}}" # <-- Composite
```

#### Adding custom regular expressions

For example, here is used the next simple regular expressions:
- `\%\{(\S+)\}` - parse `"%{tokens}"` pattern
- `\$\{(\S+)\}` - parse `"${tokens}"` pattern
- `\$\[(\S+)\]` - parse `"$[tokens]"` pattern

**Notice**, that some characters in regular expressions must be **escaped twice**!

For example - passing `\${\{(\S+)\}` option will be interpreted as `$\{(\S+)\}` 
(not `\$` at start, but `$` - not what we want). 

It must be rewritten in the next forms:
- `\\${\{(\S+)\}`     - escaping only `\$` at start
- `\\$\\{(\\S+)\\}`   - escaping all special characters (safe way, preferred)
- `[\$][\{](\S+)[\}]` - non-escaping way, wrapping special characters. Interpreted as: `[$][\{](\S+)[\}]`

Read about escaping characters in shell [here](https://stackoverflow.com/questions/15783701/which-characters-need-to-be-escaped-when-using-bash).

----

- Inline form (single `regexps` option):
    ```shell
    $ yaml_interpolate --input=input.yaml --output=processed.yaml \
        --formats=moustache \
        --regexps="\\%\\{(\\S+)\\}","\\$\\{(\\S+)\\}","\\$\\[(\\S+)\\]"
    ```
- Multi-option form (multiple `regexps` options):
    ```shell
    $ yaml_interpolate --input=input.yaml --output=processed.yaml \
        --formats=moustache \
        --regexps="\\%\\{(\\S+)\\}" \
        --regexps="\\$\\{(\\S+)\\}" \
        --regexps="\\$\\[(\\S+)\\]"
    ```

```yaml
constants:
    pi: 3.1415
    e:  2.7182

# Interpolated value: "[ 3.1415, 2.7182, 3.1415, 2.7182 ]"
text: "[ {{constants.pi}}, %{constants.e}, ${constants.pi}, $[constants.e] ]"
```

#### Piping

Piping is possible by redirecting output into `stdout` - for reading by another tool. For example - [redirecting](https://stackoverflow.com/a/59605210/) into [yq](https://mikefarah.gitbook.io/yq/) (analogue of [jq](https://stedolan.github.io/jq/)):

```shell
$ yaml_interpolate --input=input.yaml --output=stdout --formats=moustache | yq eval '.some.field' -
```

## Limitations

- You must always specify **full node path** - *relative* search not allowed, since [the content of a YAML file constitutes a `directed graph`, not a `tree`](https://stackoverflow.com/a/63579139/).
    ```yaml
    root_node:
        leaf1: "Leaf 1 text"
        leaf2: "Leaf 2 text"
        leaf3: "{{leaf1}} & {{leaf2}}" # <-- Dont works, use '{{root_node.leaf1}} & {{root_node.leaf2}}'
        leaf4: "{{.leaf5.leaf1}} & {{.leaf5.leaf2}}" # <-- Dont works, use '{{root_node.leaf5.leaf1}} & {{root_node.leaf5.leaf2}}'
        leaf5:
            leaf1: "Leaf 6 text"
            leaf2: "Leaf 7 text"
    ```
- Be careful and **avoid circular depency and recursion**.
    ```yaml
    root_node: # Dont do this:
        leaf1: "{{root_node.leaf2}}"
        leaf2: "{{root_node.leaf1}}"
        leaf3: "{{root_node.leaf2}} & {{root_node.leaf3}}"
    ```
- Nodes *keys* not transformed, only *values*.

## Dependencies

- [cxxopts](https://github.com/jarro2783/cxxopts)
    - Commit [5eca8a30012b69b76316b71fa391a89fe09256cb](https://github.com/jarro2783/cxxopts/commit/5eca8a30012b69b76316b71fa391a89fe09256cb)
- [yaml-cpp](https://github.com/jbeder/yaml-cpp)
    - Commit [0d9dbcfe8c0df699aed8ae050dddaca614178fb1](https://github.com/jbeder/yaml-cpp/commit/0d9dbcfe8c0df699aed8ae050dddaca614178fb1)