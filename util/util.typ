#import "@preview/t4t:0.3.2": *

/// RegExp to convert DateStrings to date
///
/// Regular Expression `^(\d{4})-(\d{1,2})-(\d{1,2})$` allows for single digit day and month values.
#let REGEXP_DATE_FROM_STRING = regex(`^(\d{4})-(\d{1,2})-(\d{1,2})$`.text)

/// This function creates a date from a `YYYY-MM-DD` string. 
///
/// The string needs to be in the format `YYYY-MM-DD` eg `2024-02-18` or `YYYY-M-D` 
///
/// - str (string): A string in the format `YYYY-MM-DD`. 
/// -> datetime
#let DateFromString(str) = {
  assert.that( is.str(str), message: "DateFromString() needs a string as first parameter" )
  
  let r = str.match(REGEXP_DATE_FROM_STRING) 
  assert.not-none(r, message: "DateFromString() first parameter does not match yyyy-mm-dd")

  return datetime(
    year: int(r.captures.at(0)),
    month: int(r.captures.at(1)),
    day: int(r.captures.at(2)),
  )
}

/// This function converts a full datetime element into a date only datetime element
///
/// - dt (datetime): A datetime element that has the day, month, year fields set. 
/// -> datetime
#let DatetimetoDate(dt) = {
  assert.that( is.all-of-type(datetime, dt), message: "DatetimetoDate() needs a datetime parameter" )
  assert.that( is.not-none(dt.year(), dt.month(), dt.day()), message: "DatetimetoTime() needs a datetime parameter with not none year, month and day fields." )

  let nd = datetime(year: dt.year(), month: dt.month(), day: dt.day())
  return nd
}

/// This function converts a full datetime element into a time only datetime element
///
/// - dt (datetime): A datetime element that has the hour, minute, second fields set. 
/// -> datetime
#let DatetimetoTime(dt) = {
  assert.that( is.all-of-type(datetime, dt), message: "DatetimetoTime() needs a datetime parameter" )
  assert.that( is.not-none(dt.hour(), dt.minute(), dt.second()), message: "DatetimetoTime() needs a datetime parameter with not none hour, minute and second fields." )
  let nd = datetime(hour: dt.hour(), minute: dt.minute(), second: dt.second())
  return nd
}

#let MakeCoordinates(x1,y1,x2,y2) = {
  return (x1: x1,
          y1: y1,
          x2: x2,
          y2: y2,
          width: x2 - x1,
          height: y2 - y1,
        )
}

/// This function returns an array of datetimes for a fixed number of days
/// from a start date
///
/// - start (datetime): a start date
/// - number (int): the number of dates to generate
/// -> array
#let CalculateDates(start, number) = {
  return range(int(number)).map((idx) => {
    start + duration(days:1*idx)
  })
}

/// This function calculates coordinates for a fixed number of boxes inside
/// the `size.width` x `size.height`.
///
/// - size (dictionary): a dictionary with keys `width` and `height`, both of type length.
/// - number (int): the number of boxes for which coordinates shall be calculated
/// - config (dictionary):  a dictionary with key `gap` of type length. referencing the gap that should be between the calculated boxes.
/// -> array: an array of dictionaries with the keys `x1`,`y1`,`x2`,`y2`
#let CalculateBoxes(size, number, config) = {
  let gap = config.gap;
  let sumGaps = gap*(number - 1)
  let availableWidth = size.width - sumGaps
  let availableHeight = size.height - config.header.height
  let boxWidth = availableWidth/number
  let boxes = ()
  for i in range(int(number)) {
    let box = MakeCoordinates(
          i*(boxWidth+gap),
          availableHeight,
          i*(boxWidth+gap)+boxWidth,
          0pt
          )
    boxes.push(box) 
  }
  return boxes
}

/// This function calculates a fixed number of subsection
/// dividers inside a defined rectangle. It will also
/// include an additional line on the bottom.
/// - rect (dictionary): a dictionary with keys `x`, `y`, `width`,`height` all of type length.
/// - number (int): the number of subsections for which coordinates shall be calculated
#let CalculateVerticalSubSections(rect, number) = {
  let lines = ()
  let sectionHeight = rect.height / number
  for i in range(int(number)+1) {
    let line = MakeCoordinates(
                rect.x,
                rect.y + i * sectionHeight,
                rect.x + rect.width,
                rect.y + i * sectionHeight
              )
    lines.push(line) 
  }
  return lines
}

