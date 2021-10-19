TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

# ------------------------------------------------------------------------------
# Yaml-cpp

YAML_CPP_PATH = $$PWD/third_party/yaml-cpp-yaml-cpp-0.7.0
include($$PWD/third_party/yaml-cpp.pri)

# ------------------------------------------------------------------------------
# cxxopts

INCLUDEPATH += $$PWD/third_party/cxxopts-master/include/

# ------------------------------------------------------------------------------

SOURCES += \
    main.cpp \
    utils/RegexpWithPattern.cpp \
    utils/string_split.cpp \
    utils/string_trim.cpp \
    yaml_transform/transform_nodes.cpp \
    yaml_transform/transform_with_regexp.cpp

HEADERS += \
    utils/RegexpWithPattern.hpp \
    utils/failure_mesage.hpp \
    utils/string_split.hpp \
    utils/string_trim.hpp \
    utils/vector_make_unique.hpp \
    yaml_transform/transform_nodes.hpp \
    yaml_transform/transform_with_regexp.hpp
