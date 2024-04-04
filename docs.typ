#import "@preview/tidy:0.2.0"

#let docs = tidy.parse-module(read("lib.typ"), name: "planner")

#let docs_utils = tidy.parse-module(read("util/util.typ"), name: "planner.util")
// #let pkgData = toml("typst.toml")

#tidy.show-module(docs, style: tidy.styles.default)


#tidy.show-module(docs_utils, style: tidy.styles.default)

