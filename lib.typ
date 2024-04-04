#import "@preview/cetz:0.2.2"
#import "util/util.typ": *

/// this is the default style dictionary
#let _style = (
  background: none, //(
    //fill: luma(98%),
    //radius: 1mm,
  //),
  day: (
    fill: none,
    stroke: none,//(paint: luma(60%), thickness: 0.5pt),
    radius: 1mm,
  ),
  event: (
    radius: 1mm,
    titleFont: "PT Sans",
    titleFontSize: 6pt,
    titleFontWeight: "semibold",
    titleFill: luma(10),
    textFont: "PT Sans",
    textFontSize: 6pt,
    textFill: luma(10),
  ),
  hourLabel: (
    fill: white,
    font: "IBM Plex Mono",
    fontSize: 5pt,
  ),
  hourLine: (
    stroke: (
      paint: luma(80%),
      thickness: 0.5pt,
      dash: "dashed",
    )
  ),
  halfHourLine: (
    stroke: (
      paint: luma(90%),
      thickness: 0.5pt,
      dash: "dashed",
    )
  ),
  other:  gradient.linear(..color.map.turbo).sample(0%)
)

/// This function generates a day-planner in the current layout box.
/// - data (dictonary): a dictionary defining the basics for this day-planner
/// - events (dictonary): a dictionary defining the events that should be displayed 
/// - style (dictonary): a dictionary defining the style
#let day-planner(
  data: (
      start: datetime(
      year: 2024,
      month: 7,
      day: 08,
    ),
    end: datetime(
      year: 2024,
      month: 7,
      day: 12,
    ),
    config:(
      language: "en",
      hours: 14,
      start: 8,
      gap: 2mm,
      hourGap: 7mm,
      header: (
        height: 15mm,
        label: (day) => {
          [*#day.display("[weekday repr:long]")*\ #day.display("[day] [month repr:long]")]
        },
      ),
      hourLabel: (
        label: (time) => {
          [#time.display("[hour]:[minute]")]
        }
      ),
      event: (
        label: (event, style) => {
          box(width: 100%, height: 100%, inset: 2pt, clip: true, block(spacing:0em,par(leading: 0.4em)[#text(font: style.event.titleFont, size: style.event.titleFontSize, fill: style.event.titleFill, weight: style.event.titleFontWeight )[#event.title]\ #text(font:style.event.textFont,size: style.event.textFontSize,fill: style.event.textFill, [#event.text])]))
        },
        box: (boxInfo, event) => {
          cetz.draw.rect((boxInfo.xy.x1,boxInfo.xy.y1),(boxInfo.xy.x2,boxInfo.xy.y2), fill: boxInfo.fill, radius: boxInfo.radius)
          cetz.draw.rect((boxInfo.xy.x1,boxInfo.xy.y1),(boxInfo.xy.x1+1mm,boxInfo.xy.y2), fill: event.color.darken(10%), radius: boxInfo.radius)
        } 
      )
    ),
  ), 
  events: (
    (
      start: datetime(year:2024,month:7, day:08, hour: 06, minute:00, second: 0),
      end: datetime(year:2024,month:7, day:08, hour: 8, minute:30, second: 0),
      title: [*Arrival Narita Airport*],
      text: [ ],
      color: color.hsl(160deg, 50%, 90%)
    ),
    (
      start: datetime(year:2024,month:7, day:08, hour: 8, minute:54, second: 0),
      end: datetime(year:2024,month:7, day:08, hour: 10, minute:12, second: 0),
      title: [*Transfer to Tsukiji Outer Market*],
      text: [ via Narita Airport Terminal 2･3 Station to Higashi-ginza Station ],
      color: color.hsl(160deg, 50%, 90%)
    ),
    (
      start: datetime(year:2024,month:7, day:08, hour: 10, minute:30, second: 0),
      end: datetime(year:2024,month:7, day:08, hour: 12, minute:00, second: 0),
      title: [*Late Breakfast*],
      text: [ Sashimi Rice Bowl / Himono ],
      color: color.hsl(160deg, 50%, 90%)
    ),
    (
      start: datetime(year:2024,month:7, day:08, hour: 12, minute:15, second: 0),
      end: datetime(year:2024,month:7, day:08, hour: 12, minute:30, second: 0),
      title: [*Transfer to Asakusa*],
      text: [ take Toei subway line ],
      color: color.hsl(160deg, 50%, 90%)
    ),
    (
      start: datetime(year:2024,month:7, day:08, hour: 12, minute:45, second: 0),
      end: datetime(year:2024,month:7, day:08, hour: 14, minute:30, second: 0),
      title: [*Asakusa*],
      text: [ 
        - Thunder-Gates (Kaminorimon) 
        - Senso-Ji temple
        - Street food
        - Hanayashiki
       ],
      color: color.hsl(160deg, 50%, 90%)
    ),

    (
      start: datetime(year:2024,month:7, day:12, hour: 14, minute:30, second: 0),
      end: datetime(year:2024,month:7, day:12, hour: 21, minute:45, second: 0),
      title: [*Departure Narita Airport*],
      text: [ ],
      color: color.hsl(160deg, 50%, 90%)
    ),
    (
      start: datetime(year:2024,month:7, day:9, hour: 6, minute:30, second: 0),
      end: datetime(year:2024,month:7, day:9, hour: 10, minute:45, second: 0),
      title: [*Departure Narita Airport*],
      text: [ ],
      color: color.hsl(160deg, 50%, 90%)
    ),
    (
      start: datetime(year:2024,month:7, day:9, hour: 20, minute:30, second: 0),
      end: datetime(year:2024,month:7, day:9, hour: 23, minute:45, second: 0),
      title: [*Departure Narita Airport*],
      text: [ ],
      color: color.hsl(160deg, 50%, 90%)
    ),
    (
      start: datetime(year:2024,month:7, day:10, hour:06, minute:30, second: 0),
      end: datetime(year:2024,month:7, day:10, hour: 23, minute:45, second: 0),
      title: [*Departure Narita Airport*],
      text: [ ],
      color: color.hsl(160deg, 50%, 90%)
    ),
  ),
  style: _style
) = {
layout(size => {
  cetz.canvas(
    debug:false,
  {
    import cetz.draw: *
    stroke(none)

    // background rect
    if style.background != none{
      rect((0,0), (size.width, size.height), fill: style.background.fill, radius: style.background.radius)
    }else{
      rect((0,0), (size.width, size.height), fill: style.background)
    }
    
    let numDays = int((data.end - data.start).days()+1)
    let dayBoxes = CalculateBoxes(size, numDays, data.config)
    let dayDates = CalculateDates(data.start, numDays)
    
    let days = dayDates.zip(dayBoxes, range(numDays))

    for (currentday, dbox, idx) in days {
      //header
      if(data.config.header != none){
        content((dbox.x1,size.height),(dbox.x2,size.height - data.config.header.height),(data.config.header.label)(currentday))
      }

      // day box
      rect((dbox.x1,dbox.y1),(dbox.x2,dbox.y2), stroke: style.day.stroke, fill: style.day.fill, radius: style.day.radius)

      // calc & draw subsections
      let r = (x: dbox.x1,
               y: dbox.y1,
               width: dbox.x2 - dbox.x1,
               height: dbox.y2 - dbox.y1)
      let lines = CalculateVerticalSubSections(r, data.config.hours*2)

      for i in range(lines.len(), step: 2) {
        let hourTime = datetime(hour: int(i/2)+data.config.start, minute:0, second: 0)
        let halfHourTime = datetime(hour: int(i/2)+data.config.start, minute:30, second: 0)
        let labelfull = (data.config.hourLabel.label)(hourTime)
        let labelhalf = (data.config.hourLabel.label)(halfHourTime)

        let hourLine = lines.at(i)        
        if(style.day.stroke != none and ( i == 0 or i==lines.len()) ){
          // skip if day box already has a stroke 
          line((hourLine.x1,hourLine.y1),(hourLine.x2,hourLine.y2), stroke: none, name: "hourLine")
        }else{
          line((hourLine.x1,hourLine.y1),(hourLine.x2,hourLine.y2), stroke: style.hourLine.stroke, name: "hourLine")
        }
        if style.hourLabel != none {
          content("hourLine.start", anchor:"west", padding: 1pt, box(fill: style.hourLabel.fill, inset: 1pt)[#text(font: style.hourLabel.font, size: style.hourLabel.fontSize)[#labelfull]]) 
        }
        
        if( i+1 < lines.len()){
          let halfHourLine = lines.at(i+1)
          line((halfHourLine.x1,halfHourLine.y1),(halfHourLine.x2,halfHourLine.y2), stroke: style.halfHourLine.stroke, name:"halfHourLine")
          if style.hourLabel != none {
            content("halfHourLine.start", anchor:"west", padding: 1pt, box(fill: white, inset: 1pt)[#text(font: style.hourLabel.font,size: style.hourLabel.fontSize)[#labelhalf]]) 
          }
        }
      }
    }

    for event in events {
      let timeDistance = DatetimetoDate(event.start) - data.start
      if( timeDistance.days() >= 0 and timeDistance.days() <= numDays){
        let idx = int(timeDistance.days())
        

        let hheight = (dayBoxes.at(idx).height / data.config.hours)
        let start = DatetimetoTime(event.start) - datetime(hour:data.config.start, minute:0, second: 0)
        start = start.minutes()/60 * hheight
        let end = DatetimetoTime(event.end) - datetime(hour:data.config.start, minute:0, second: 0)
        end = end.minutes()/60 * hheight
        
        let x = dayBoxes.at(idx).x1 + data.config.hourGap
        let y = dayBoxes.at(idx).y1 + start
        let x2 = dayBoxes.at(idx).x2
        let y2 = dayBoxes.at(idx).y1 + end

        let boxRadius = style.event.radius
        if  type(boxRadius) != dictionary {
          boxRadius = (
            north-east: style.event.radius,
            north-west: style.event.radius,
            south-east: style.event.radius,
            south-west: style.event.radius,
            )
        }
        let boxColor = event.color
        // overflow top
        if y > dayBoxes.at(idx).y1 {
          boxRadius.north-east = 0pt
          boxRadius.north-west = 0pt
          let alphaColor = event.color.transparentize(70%)
           boxColor = gradient.linear(
              angle: 90deg,
              (alphaColor, 0%),
              (event.color, 20%),
              (event.color, 100%),
            )
           y = dayBoxes.at(idx).y1
        }

         // overflow bottom
        if y2 < dayBoxes.at(idx).y2 {
          boxRadius.south-east = 0pt
          boxRadius.south-west = 0pt
          let alphaColor = event.color.transparentize(70%)
          boxColor = gradient.linear(
              angle: 90deg,
              (event.color, 0%),
              (event.color, 80%),
              (alphaColor, 100%),
            )
            // check if overflow top as well?
            if type(boxRadius) == gradient{
              boxColor = gradient.linear(
              angle: 90deg,
              (alphaColor, 0%),
              (event.color, 10%),
              (event.color, 90%),
              (alphaColor, 100%),
            )
            }
           y2 = dayBoxes.at(idx).y2
        }
        
        let boxInfo = (
          xy: MakeCoordinates(x,y,x2,y2),
          fill: boxColor,
          radius: boxRadius
        )

        (data.config.event.box)(boxInfo,event)
        let label = (data.config.event.label)(event, style)
        content((x,y),(x2,y2), label)
        
      }
    }

    

    // debug
    //content((size.width/2,size.height/2),anchor: "west", padding: .1, text(size: 10pt)[dbg: #dayBoxes.slice(0,2)], size:3)
  })
})
} 