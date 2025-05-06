import Foundation

extension Date {
    
    public var dayOfWeek: Int? {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.day], from: self)
        return components.weekday
    }
    
    /**
     Returns a new date by adding the given number of days to the receiver.
     
     - parameter days:     The number of days to add.
     - parameter calendar: The calendar to use to determine how long each day is (default is current calendar).
     - parameter timeZone: The time zone to treat the calendar in (default is GMT).
     
     - returns: A new date by adding the given number of days to the receiver.
     */
    public func dateByAddingNumberOfDays(_ days: Int, calendar: Calendar = Calendar.current, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) -> Date {
        var calendar = calendar
        calendar.timeZone = timeZone
        var components: DateComponents = DateComponents()
        components.day = days
        return (calendar as NSCalendar).date(byAdding: components, to: self, options: [])!
    }
    
    /**
     Returns a new date by treating the receiver as a day and setting the time to
     midnight, plus the given number of hours and given number of minutes.
     
     For example, if the receiver is "02/05/2016 15:35" and the hour and
     minutes are 6 and 30 respectively, then the returned date will be
     "02/15/2016 06:30". The time zone is taken into consideration when
     determining which day it is, i.e. from when in time the midnight offset is.
     
     - parameter hour:     The number of hours to add.
     - parameter minutes:  The number of minutes to add.
     - parameter timeZone: The time zone to treat the date in.
     
     - returns: A new date with the hour and minute set to those passed in.
     */
    public func dateForMidnight(plusHours hours: Int = 0, plusMinutes minutes: Int = 0, inTimeZone timeZone: TimeZone? = nil) -> Date {
        var calendar = Calendar.current
        if let timeZone = timeZone {
            calendar.timeZone = timeZone
        }
        var components = (calendar as NSCalendar).components([.year, .month, .day], from: self)
        components.hour = hours
        components.minute = minutes
        return calendar.date(from: components)!
    }
    
}

// MARK: Comparison before

/**
 Checks if the first date is "less than" the second date, i.e. it is before.
 
 - parameter date:      The first date to check.
 - parameter otherDate: The second date to check.
 
 - returns: True if the first place is before the second, otherwise false.
 */
public func < (date: Date?, otherDate: Date) -> Bool {
    return date.flatMap { $0.compare(otherDate) == .orderedAscending } ?? false
}

/**
 Checks if the first date is "less than or equal to" the second date, i.e. it is before, or the same.
 
 - parameter date:      The first date to check.
 - parameter otherDate: The second date to check.
 
 - returns: True if the first place is before or equal to the second, otherwise false.
 */
public func <= (date: Date?, otherDate: Date) -> Bool {
    return date.flatMap { $0.compare(otherDate) != .orderedDescending } ?? false
}

// MARK: Comparison after

/**
 Checks if the first date is "greater than" the second date, i.e. it is after.
 
 - parameter date:      The first date to check.
 - parameter otherDate: The second date to check.
 
 - returns: True if the first place is after the second, otherwise false.
 */
public func > (date: Date?, otherDate: Date) -> Bool {
    return date.flatMap { $0.compare(otherDate) == .orderedDescending } ?? false
}

/**
 Checks if the first date is "greater than or equal to" the second date, i.e. it is after, or the same.
 
 - parameter date:      The first date to check.
 - parameter otherDate: The second date to check.
 
 - returns: True if the first place is after or equal to the second, otherwise false.
 */
public func >= (date: Date?, otherDate: Date) -> Bool {
    return date.flatMap { $0.compare(otherDate) != .orderedAscending } ?? false
}
