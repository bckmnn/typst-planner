#import "lib.typ": *

#let events = (
  
)

#set page(
    paper: "a4",
    header: rect(fill: black)[#text(size: 18pt, fill: white, weight: "light")[Itinary - Trip to Tokyo]],
    footer: rect(fill: black)[#text(size: 12pt, fill: white, weight: "light")[Footer]],
    margin: (top: 2cm, rest: 1cm),
    number-align: center,
  )

#box(height: 50%,
  day-planner()
)

