#! /usr/bin/env bash


# ------------------------------------------------------------------------------
# Question: Why this shell-script used to build executable, not by using build 
#           system like CMake/QMake/etc?
#
# Answer  : To build this simple executable we actually DONT NEED anything, 
#           except compiler and linker.
#
#           Using simple shell-script simplify CI scenarious, since we dont need
#           to install anything, and generate Makefile for compiling by 'make'.
#
#           Managing various build systems is a mess, so, if you need 
#           alternatives - unfortunately, you need to write your own yourself.
# ------------------------------------------------------------------------------


# If project path not specified - assume it is 'current directory'
# via: https://stackoverflow.com/a/9333006/
PROJ_DIR=${1:-`pwd`}

# Notice, that used 'Link-time Optimization' (LTO) during compilation AND linking - to reduce executable size

# ----------------------------------------------------------------------------------------------------------------------------

YAML_CPP_DIR="$PROJ_DIR/third_party/yaml-cpp-yaml-cpp-0.7.0"
YAML_CPP_INCLUDE="$YAML_CPP_DIR/include"
YAML_CPP_LIB_INCLUDES="-I $YAML_CPP_INCLUDE -I $YAML_CPP_DIR/src"


g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/binary.cpp                      -o yaml_cpp__binary.o

g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/contrib/graphbuilderadapter.cpp -o yaml_cpp__graphbuilderadapter.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/contrib/graphbuilder.cpp        -o yaml_cpp__graphbuilder.o

g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/convert.cpp                     -o yaml_cpp__convert.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/depthguard.cpp                  -o yaml_cpp__depthguard.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/directives.cpp                  -o yaml_cpp__directives.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/emit.cpp                        -o yaml_cpp__emit.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/emitfromevents.cpp              -o yaml_cpp__emitfromevents.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/emitter.cpp                     -o yaml_cpp__emitter.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/emitterstate.cpp                -o yaml_cpp__emitterstate.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/emitterutils.cpp                -o yaml_cpp__emitterutils.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/exceptions.cpp                  -o yaml_cpp__exceptions.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/exp.cpp                         -o yaml_cpp__exp.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/memory.cpp                      -o yaml_cpp__memory.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/nodebuilder.cpp                 -o yaml_cpp__nodebuilder.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/node.cpp                        -o yaml_cpp__node.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/node_data.cpp                   -o yaml_cpp__node_data.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/nodeevents.cpp                  -o yaml_cpp__nodeevents.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/null.cpp                        -o yaml_cpp__null.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/ostream_wrapper.cpp             -o yaml_cpp__ostream_wrapper.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/parse.cpp                       -o yaml_cpp__parse.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/parser.cpp                      -o yaml_cpp__parser.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/regex_yaml.cpp                  -o yaml_cpp__regex_yaml.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/scanner.cpp                     -o yaml_cpp__scanner.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/scanscalar.cpp                  -o yaml_cpp__scanscalar.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/scantag.cpp                     -o yaml_cpp__scantag.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/scantoken.cpp                   -o yaml_cpp__scantoken.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/simplekey.cpp                   -o yaml_cpp__simplekey.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/singledocparser.cpp             -o yaml_cpp__singledocparser.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/stream.cpp                      -o yaml_cpp__stream.o
g++ --std=c++11 -O2 -flto $YAML_CPP_LIB_INCLUDES -c $YAML_CPP_DIR/src/tag.cpp                         -o yaml_cpp__tag.o

# ----------------------------------------------------------------------------------------------------------------------------

CXXOPTS_INCLUDE="$PROJ_DIR/third_party/cxxopts-master/include" 

# ----------------------------------------------------------------------------------------------------------------------------

g++ --std=c++11 -O2 -flto -I $PROJ_DIR -c "$PROJ_DIR/utils/string_split.cpp" -o utils__string_split.o
g++ --std=c++11 -O2 -flto -I $PROJ_DIR -c "$PROJ_DIR/utils/string_trim.cpp"  -o utils__string_trim.o
g++ --std=c++11 -O2 -flto -I $PROJ_DIR -c "$PROJ_DIR/utils/RegexpWithPattern.cpp" -o utils__RegexpWithPattern.o

g++ --std=c++11 -O2 -flto -I $PROJ_DIR -I $YAML_CPP_INCLUDE -c "$PROJ_DIR/yaml_transform/transform_nodes.cpp"       -o transform_nodes.o
g++ --std=c++11 -O2 -flto -I $PROJ_DIR -I $YAML_CPP_INCLUDE -c "$PROJ_DIR/yaml_transform/transform_with_regexp.cpp" -o transform_with_regexp.o

g++ --std=c++11 -O2 -flto -I $PROJ_DIR -I $YAML_CPP_INCLUDE -I $CXXOPTS_INCLUDE -c "$PROJ_DIR/main.cpp" -o main.o

# ----------------------------------------------------------------------------------------------------------------------------
# Link object files into executable

g++ \
    -o yaml_interpolate \
    -flto \
    \
    yaml_cpp__binary.o \
    yaml_cpp__graphbuilderadapter.o \
    yaml_cpp__graphbuilder.o \
    yaml_cpp__convert.o \
    yaml_cpp__depthguard.o \
    yaml_cpp__directives.o \
    yaml_cpp__emit.o \
    yaml_cpp__emitfromevents.o \
    yaml_cpp__emitter.o \
    yaml_cpp__emitterstate.o \
    yaml_cpp__emitterutils.o \
    yaml_cpp__exceptions.o \
    yaml_cpp__exp.o \
    yaml_cpp__memory.o \
    yaml_cpp__nodebuilder.o \
    yaml_cpp__node.o \
    yaml_cpp__node_data.o \
    yaml_cpp__nodeevents.o \
    yaml_cpp__null.o \
    yaml_cpp__ostream_wrapper.o \
    yaml_cpp__parse.o \
    yaml_cpp__parser.o \
    yaml_cpp__regex_yaml.o \
    yaml_cpp__scanner.o \
    yaml_cpp__scanscalar.o \
    yaml_cpp__scantag.o \
    yaml_cpp__scantoken.o \
    yaml_cpp__simplekey.o \
    yaml_cpp__singledocparser.o \
    yaml_cpp__stream.o \
    yaml_cpp__tag.o \
    \
    utils__string_split.o \
    utils__string_trim.o \
    utils__RegexpWithPattern.o \
    \
    transform_nodes.o \
    transform_with_regexp.o \
    \
    main.o

# Cleanup: Remove object files
rm *.o
