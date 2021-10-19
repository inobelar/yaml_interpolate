# ------------------------------------------------------------------------------
# # Example of usage:
#
# Add it to your .pro file:
#
#     YAML_CPP_PATH = path/to/yaml-cpp/
#     include(yaml-cpp.pri)
#
# ------------------------------------------------------------------------------

# Make sure that YAML-CPP's path variable specified
if(isEmpty(YAML_CPP_PATH)) {
    error("YAML_CPP path not defined. For example: path/to/yaml-cpp/")
}

INCLUDEPATH += \
    $${YAML_CPP_PATH}/include/

HEADERS += \
    $${YAML_CPP_PATH}/include/yaml-cpp/anchor.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/binary.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/contrib/anchordict.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/contrib/graphbuilder.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/depthguard.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/dll.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/emitfromevents.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/emitterdef.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/emitter.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/emittermanip.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/emitterstyle.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/eventhandler.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/exceptions.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/mark.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/convert.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/detail/impl.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/detail/iterator_fwd.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/detail/iterator.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/detail/memory.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/detail/node_data.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/detail/node.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/detail/node_iterator.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/detail/node_ref.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/emit.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/impl.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/iterator.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/node.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/parse.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/ptr.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/node/type.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/noexcept.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/null.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/ostream_wrapper.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/parser.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/stlemitter.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/traits.h \
    $${YAML_CPP_PATH}/include/yaml-cpp/yaml.h

# ------------------------------------------------------------------------------

INCLUDEPATH += \
    $${YAML_CPP_PATH}/src/

SOURCES += $${YAML_CPP_PATH}/src/binary.cpp
HEADERS += $${YAML_CPP_PATH}/src/collectionstack.h

SOURCES += $${YAML_CPP_PATH}/src/contrib/graphbuilderadapter.cpp
HEADERS += $${YAML_CPP_PATH}/src/contrib/graphbuilderadapter.h
SOURCES += $${YAML_CPP_PATH}/src/contrib/graphbuilder.cpp

SOURCES += $${YAML_CPP_PATH}/src/convert.cpp
SOURCES += $${YAML_CPP_PATH}/src/depthguard.cpp
SOURCES += $${YAML_CPP_PATH}/src/directives.cpp
HEADERS += $${YAML_CPP_PATH}/src/directives.h
SOURCES += $${YAML_CPP_PATH}/src/emit.cpp
SOURCES += $${YAML_CPP_PATH}/src/emitfromevents.cpp
SOURCES += $${YAML_CPP_PATH}/src/emitter.cpp
SOURCES += $${YAML_CPP_PATH}/src/emitterstate.cpp
HEADERS += $${YAML_CPP_PATH}/src/emitterstate.h
SOURCES += $${YAML_CPP_PATH}/src/emitterutils.cpp
HEADERS += $${YAML_CPP_PATH}/src/emitterutils.h
SOURCES += $${YAML_CPP_PATH}/src/exceptions.cpp
SOURCES += $${YAML_CPP_PATH}/src/exp.cpp
HEADERS += $${YAML_CPP_PATH}/src/exp.h
HEADERS += $${YAML_CPP_PATH}/src/indentation.h
SOURCES += $${YAML_CPP_PATH}/src/memory.cpp
SOURCES += $${YAML_CPP_PATH}/src/nodebuilder.cpp
HEADERS += $${YAML_CPP_PATH}/src/nodebuilder.h
SOURCES += $${YAML_CPP_PATH}/src/node.cpp
SOURCES += $${YAML_CPP_PATH}/src/node_data.cpp
SOURCES += $${YAML_CPP_PATH}/src/nodeevents.cpp
HEADERS += $${YAML_CPP_PATH}/src/nodeevents.h
SOURCES += $${YAML_CPP_PATH}/src/null.cpp
SOURCES += $${YAML_CPP_PATH}/src/ostream_wrapper.cpp
SOURCES += $${YAML_CPP_PATH}/src/parse.cpp
SOURCES += $${YAML_CPP_PATH}/src/parser.cpp
HEADERS += $${YAML_CPP_PATH}/src/ptr_vector.h
HEADERS += $${YAML_CPP_PATH}/src/regeximpl.h
SOURCES += $${YAML_CPP_PATH}/src/regex_yaml.cpp
HEADERS += $${YAML_CPP_PATH}/src/regex_yaml.h
SOURCES += $${YAML_CPP_PATH}/src/scanner.cpp
HEADERS += $${YAML_CPP_PATH}/src/scanner.h
SOURCES += $${YAML_CPP_PATH}/src/scanscalar.cpp
HEADERS += $${YAML_CPP_PATH}/src/scanscalar.h
SOURCES += $${YAML_CPP_PATH}/src/scantag.cpp
HEADERS += $${YAML_CPP_PATH}/src/scantag.h
SOURCES += $${YAML_CPP_PATH}/src/scantoken.cpp
HEADERS += $${YAML_CPP_PATH}/src/setting.h
SOURCES += $${YAML_CPP_PATH}/src/simplekey.cpp
SOURCES += $${YAML_CPP_PATH}/src/singledocparser.cpp
HEADERS += $${YAML_CPP_PATH}/src/singledocparser.h
HEADERS += $${YAML_CPP_PATH}/src/streamcharsource.h
SOURCES += $${YAML_CPP_PATH}/src/stream.cpp
HEADERS += $${YAML_CPP_PATH}/src/stream.h
HEADERS += $${YAML_CPP_PATH}/src/stringsource.h
SOURCES += $${YAML_CPP_PATH}/src/tag.cpp
HEADERS += $${YAML_CPP_PATH}/src/tag.h
HEADERS += $${YAML_CPP_PATH}/src/token.h
