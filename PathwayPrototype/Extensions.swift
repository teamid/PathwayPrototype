//
//  Extensions.swift
//  PathwayPrototype
//
//  Created by David Smith on 11/12/15.
//  Copyright © 2015 David Smith. All rights reserved.
//

import UIKit


func callOnBackgroundQueue(f: () -> ()) {
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { f() }
}

func callOnMainQueue(f: () -> ()) {
      dispatch_async(dispatch_get_main_queue()) { f() }
}



// MARK: —— NSDate —————————————————————————————————————————————————————— //
extension NSDate: Comparable {
      
      
      convenience init?(jsonDate: String) {
            let prefix = "/Date("
            let suffix = ")/"
            if jsonDate.hasPrefix(prefix) && jsonDate.hasSuffix(suffix) {
                  let from = jsonDate.startIndex.advancedBy(prefix.characters.count)
                  let to = jsonDate.endIndex.advancedBy(-suffix.characters.count)
                  let dateString = jsonDate[from ..< to]
                  let timeStamp = (dateString as NSString).doubleValue / 1000.0
                  self.init(timeIntervalSince1970: timeStamp)
            } else {
                  self.init(timeIntervalSince1970: 0)
                  return nil
            }
      }
      func yearsFrom(date:NSDate) -> Int{
            return NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: date, toDate: self, options: []).year
      }
      func monthsFrom(date:NSDate) -> Int{
            return NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: date, toDate: self, options: []).month
      }
      func weeksFrom(date:NSDate) -> Int{
            return NSCalendar.currentCalendar().components(NSCalendarUnit.WeekOfYear, fromDate: date, toDate: self, options: []).weekOfYear
      }
      func daysFrom(date:NSDate) -> Int{
            return NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: date, toDate: self, options: []).day
      }
      func hoursFrom(date:NSDate) -> Int{
            return NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: date, toDate: self, options: []).hour
      }
      func minutesFrom(date:NSDate) -> Int{
            return NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: date, toDate: self, options: []).minute
      }
      func secondsFrom(date:NSDate) -> Int{
            return NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: date, toDate: self, options: []).second
      }
      func offsetFrom(date:NSDate) -> String {
            if yearsFrom(date)  > 0 { return "\(yearsFrom(date))y"  }
            if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
            if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
            if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
            if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
            if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
            return ""
      }
      func longOffsetFrom(date:NSDate) -> String {
            let years = yearsFrom(date)
            let weeks = monthsFrom(date)
            let days = daysFrom(date)
            
            if years>0 { return years>1 ? "\(years) years" : "\(years) year" }
            if weeks>0 { return weeks>1 ? "\(weeks) weeks" : "\(weeks) week" }
            return days>1 ? "\(days) days" : "1 day"
      }
      //      func longStyle() -> String {
      //            let formatter = NSDateFormatter()
      //            formatter.dateStyle = .LongStyle
      //            return formatter.stringFromDate(self)
      //      }
      //
      //      func mediumStyle() -> String {
      //            let formatter = NSDateFormatter()
      //            formatter.dateStyle = .MediumStyle
      //            return formatter.stringFromDate(self)
      //      }
      //
      //      func shortStyle() -> String {
      //            let formatter = NSDateFormatter()
      //            formatter.timeStyle = .ShortStyle
      //            return formatter.stringFromDate(self)
      //      }
      func stringWithStyle(style: NSDateFormatterStyle) -> String {
            let formatter = NSDateFormatter()
            formatter.timeStyle = style
            return formatter.stringFromDate(self)
      }
      
      
      public func add(seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, weeks: Int = 0, months: Int = 0, years: Int = 0) -> NSDate {
            let calendar = NSCalendar.currentCalendar()
            
            let version = floor(NSFoundationVersionNumber)
            
            if version <= NSFoundationVersionNumber10_9_2 {
                  var component = NSDateComponents()
                  component.setValue(seconds, forComponent: .Second)
                  
                  var date : NSDate! = calendar.dateByAddingComponents(component, toDate: self, options: [])!
                  component = NSDateComponents()
                  component.setValue(minutes, forComponent: .Minute)
                  date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
                  
                  component = NSDateComponents()
                  component.setValue(hours, forComponent: .Hour)
                  date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
                  
                  component = NSDateComponents()
                  component.setValue(days, forComponent: .Day)
                  date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
                  
                  component = NSDateComponents()
                  component.setValue(weeks, forComponent: .WeekOfMonth)
                  date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
                  
                  component = NSDateComponents()
                  component.setValue(months, forComponent: .Month)
                  date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
                  
                  component = NSDateComponents()
                  component.setValue(years, forComponent: .Year)
                  date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
                  return date
            }
            
            var date : NSDate! = calendar.dateByAddingUnit(.Second, value: seconds, toDate: self, options: [])
            date = calendar.dateByAddingUnit(.Minute, value: minutes, toDate: date, options: [])
            date = calendar.dateByAddingUnit(.Day, value: days, toDate: date, options: [])
            date = calendar.dateByAddingUnit(.Hour, value: hours, toDate: date, options: [])
            date = calendar.dateByAddingUnit(.WeekOfMonth, value: weeks, toDate: date, options: [])
            date = calendar.dateByAddingUnit(.Month, value: months, toDate: date, options: [])
            date = calendar.dateByAddingUnit(.Year, value: years, toDate: date, options: [])
            return date
      }
      
}
public func <(a: NSDate, b: NSDate) -> Bool {
      return a.compare(b) == NSComparisonResult.OrderedAscending
}

public func ==(a: NSDate, b: NSDate) -> Bool {
      return a.compare(b) == NSComparisonResult.OrderedSame
}


public extension NSDate {
      
      /**
       Returns a new NSDate object representing the date calculated by adding an amount of seconds to self date
       
       - parameter seconds: number of seconds to add
       - returns: the NSDate computed
       */
      public func addSeconds (seconds: Int) -> NSDate {
            return add(seconds)
      }
      
      /**
       Returns a new NSDate object representing the date calculated by adding an amount of minutes to self date
       
       - parameter minutes: number of minutes to add
       - returns: the NSDate computed
       */
      public func addMinutes (minutes: Int) -> NSDate {
            return add(minutes: minutes)
      }
      
      /**
       Returns a new NSDate object representing the date calculated by adding an amount of hours to self date
       
       - parameter hours: number of hours to add
       - returns: the NSDate computed
       */
      public func addHours(hours: Int) -> NSDate {
            return add(hours: hours)
      }
      
      /**
       Returns a new NSDate object representing the date calculated by adding an amount of days to self date
       
       - parameter days: number of days to add
       - returns: the NSDate computed
       */
      public func addDays(days: Int) -> NSDate {
            return add(days: days)
      }
      
      /**
       Returns a new NSDate object representing the date calculated by adding an amount of weeks to self date
       
       - parameter weeks: number of weeks to add
       - returns: the NSDate computed
       */
      public func addWeeks(weeks: Int) -> NSDate {
            return add(weeks: weeks)
      }
      
      
      /**
       Returns a new NSDate object representing the date calculated by adding an amount of months to self date
       
       - parameter months: number of months to add
       - returns: the NSDate computed
       */
      
      public func addMonths(months: Int) -> NSDate {
            return add(months: months)
      }
      
      /**
       Returns a new NSDate object representing the date calculated by adding an amount of years to self date
       
       - parameter years: number of year to add
       - returns: the NSDate computed
       */
      public func addYears(years: Int) -> NSDate {
            return add(years: years)
      }
      
      // MARK:  Date comparison
      
      /**
      Checks if self is after input NSDate
      
      - parameter date: NSDate to compare
      - returns: True if self is after the input NSDate, false otherwise
      */
      public func isAfter(date: NSDate) -> Bool{
            return (self.compare(date) == NSComparisonResult.OrderedDescending)
      }
      
      /**
       Checks if self is before input NSDate
       
       - parameter date: NSDate to compare
       - returns: True if self is before the input NSDate, false otherwise
       */
      public func isBefore(date: NSDate) -> Bool{
            return (self.compare(date) == NSComparisonResult.OrderedAscending)
      }
      
      
      // MARK: Getter
      
      /**
      Date year
      */
      public var year : Int {
            get {
                  return getComponent(.Year)
            }
      }
      
      /**
       Date month
       */
      public var month : Int {
            get {
                  return getComponent(.Month)
            }
      }
      
      /**
       Date weekday
       */
      public var weekday : Int {
            get {
                  return getComponent(.Weekday)
            }
      }
      
      /**
       Date weekMonth
       */
      public var weekMonth : Int {
            get {
                  return getComponent(.WeekOfMonth)
            }
      }
      
      
      /**
       Date days
       */
      public var days : Int {
            get {
                  return getComponent(.Day)
            }
      }
      
      /**
       Date hours
       */
      public var hours : Int {
            
            get {
                  return getComponent(.Hour)
            }
      }
      
      /**
       Date minuts
       */
      public var minutes : Int {
            get {
                  return getComponent(.Minute)
            }
      }
      
      /**
       Date seconds
       */
      public var seconds : Int {
            get {
                  return getComponent(.Second)
            }
      }
      
      /**
       Returns the value of the NSDate component
       
       - parameter component: NSCalendarUnit
       - returns: the value of the component
       */
      
      public func getComponent (component : NSCalendarUnit) -> Int {
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(component, fromDate: self)
            
            return components.valueForComponent(component)
      }
}

extension NSDate: Strideable {
      public func distanceTo(other: NSDate) -> NSTimeInterval {
            return other - self
      }
      
      public func advancedBy(n: NSTimeInterval) -> Self {
            return self.dynamicType.init(timeIntervalSinceReferenceDate: self.timeIntervalSinceReferenceDate + n)
      }
}
// MARK: Arithmetic

func +(date: NSDate, timeInterval: Int) -> NSDate {
      return date + NSTimeInterval(timeInterval)
}

func -(date: NSDate, timeInterval: Int) -> NSDate {
      return date - NSTimeInterval(timeInterval)
}

func +=(inout date: NSDate, timeInterval: Int) {
      date = date + timeInterval
}

func -=(inout date: NSDate, timeInterval: Int) {
      date = date - timeInterval
}

func +(date: NSDate, timeInterval: Double) -> NSDate {
      return date.dateByAddingTimeInterval(NSTimeInterval(timeInterval))
}

func -(date: NSDate, timeInterval: Double) -> NSDate {
      return date.dateByAddingTimeInterval(NSTimeInterval(-timeInterval))
}

func +=(inout date: NSDate, timeInterval: Double) {
      date = date + timeInterval
}

func -=(inout date: NSDate, timeInterval: Double) {
      date = date - timeInterval
}

func -(date: NSDate, otherDate: NSDate) -> NSTimeInterval {
      return date.timeIntervalSinceDate(otherDate)
}


public func +(string: NSMutableAttributedString, new: NSMutableAttributedString) -> NSMutableAttributedString {
      string.appendAttributedString(new)
      return string
}






// MARK: —— UIScreen ————————————————————————————————————————————— //
extension UIScreen {
      
      static var height: CGFloat {
            return UIScreen.mainScreen().bounds.height
      }
      static var width: CGFloat {
            return UIScreen.mainScreen().bounds.width
      }
      
}


// MARK: —— UIImageView —————————————————————————————————————————————————————— //
extension UIImageView {
      
      var colorOverlay: UIColor? {
            get {
                  return nil
            }
            set {
                  let currImage = image
                  callOnBackgroundQueue { [weak self] in
                        guard let this = self else {return}
                        let newImg = currImage?.imageWithRenderingMode(.AlwaysTemplate)
                        callOnMainQueue {
                              this.image = newImg
                              this.tintColor = newValue
                        }
                  }
            }
      }
      
}

extension Array {
      var randomItem: Element? {
            if self.count > 0 {
                  let index = Int(arc4random_uniform(UInt32(self.count)))
                  return self[index]
            }
            return nil
      }

}


extension CGRect {
      
      var center: CGPoint {
            let centerX = CGRectGetMidX(self)
            let centerY = CGRectGetMidY(self)
            let retVal = CGPoint(x: centerX, y: centerY)
            return retVal
      }
      
}



// MARK —— Static Methods
extension UIColor {
      
      static func RGB(r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a :CGFloat) -> UIColor {
            let red = r/255
            let green = g/255
            let blue = b/255
            let alpha = a/100
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
      }
      
      static func Gray(brightness: CGFloat) -> UIColor {
            return UIColor(hue: 0, saturation: 0, brightness: brightness/100, alpha: 1)
      }
}

extension UIView {
      
      func addStrokeToPath(color: UIColor, width: CGFloat, path: UIBezierPath) {
            
            let shape = CAShapeLayer()
            shape.frame = bounds
            shape.path = path.CGPath
            shape.lineWidth = width
            shape.strokeColor = color.CGColor
            shape.fillColor = UIColor.clearColor().CGColor
                        
            layer.addSublayer(shape)
      }

}


