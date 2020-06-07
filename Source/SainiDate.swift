//
//  SainiDate.swift
//  SainiExtensions
//
//  Created by Rohit Saini on 03/08/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import Foundation
import UIKit


//MARK:- SainiFormatter
enum SainiFormatter:String{
    case MMDDYYY = "MM/dd/yyy"
    case DDMMYY = "dd/MM/yyy"
    case YYMMDD = "yyy/MM/dd"
}

extension Date{
    
    //MARK:- sianiFirstDayOfWeek
    public var sianiFirstDayOfWeek: Date {
        var beginningOfWeek = Date()
        var interval = TimeInterval()
        
        _ = Calendar.current.dateInterval(of: .weekOfYear, start: &beginningOfWeek, interval: &interval, for: self)
        return beginningOfWeek
    }
    
    //MARK:- sainiAddWeeks
    public func sainiAddWeeks(_ numWeeks: Int) -> Date {
        var components = DateComponents()
        components.weekOfYear = numWeeks
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    //MARK:- sainiWeeksAgo
    public func sainiWeeksAgo(_ numWeeks: Int) -> Date {
        return sainiAddWeeks(-numWeeks)
    }
    
    //MARK:- sainiAddDays
    public func sainiAddDays(_ numDays: Int) -> Date {
        var components = DateComponents()
        components.day = numDays
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    //MARK:- sainiDaysAgo
    public func sainiDaysAgo(_ numDays: Int) -> Date {
        return sainiAddDays(-numDays)
    }
    
    //MARK:- sainiAddHours
    public func sainiAddHours(_ numHours: Int) -> Date {
        var components = DateComponents()
        components.hour = numHours
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    //MARK:- sainiHoursAgo
   public func sainiHoursAgo(_ numHours: Int) -> Date {
        return sainiAddHours(-numHours)
    }
    
    //MARK:- sainiAddMinutes
   public func sainiAddMinutes(_ numMinutes: Double) -> Date {
        return self.addingTimeInterval(60 * numMinutes)
    }
    
    //MARK:- sainiMinutesAgo
   public func sainiMinutesAgo(_ numMinutes: Double) -> Date {
        return sainiAddMinutes(-numMinutes)
    }
    
    //MARK:- sainiStartOfDay
     public var sainiStartOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    //MARK:- sainiEndOfDay
     public var sainiEndOfDay: Date {
        let cal = Calendar.current
        var components = DateComponents()
        components.day = 1
        return cal.date(byAdding: components, to: self.sainiStartOfDay)!.addingTimeInterval(-1)
    }
    
    //MARK:- sainiZeroBasedDayOfWeek
    public  var sainiZeroBasedDayOfWeek: Int? {
        let comp = Calendar.current.component(.weekday, from: self)
        return comp - 1
    }
    
    //MARK:- sainiHoursFrom
    public func sainiHoursFrom(_ date: Date) -> Double {
        return Double(Calendar.current.dateComponents([.hour], from: date, to: self).hour!)
    }
    
    //MARK:- sainiDaysBetween
    public func sainiDaysBetween(_ date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self.sainiStartOfDay, to: date.sainiStartOfDay)
        
        return components.day!
    }
    
    //MARK:- sainiPercentageOfDay
    public var sainiPercentageOfDay: Double {
        let totalSeconds = self.sainiEndOfDay.timeIntervalSince(self.sainiStartOfDay) + 1
        let seconds = self.timeIntervalSince(self.sainiStartOfDay)
        let percentage = seconds / totalSeconds
        return max(min(percentage, 1.0), 0.0)
    }
    
    //MARK:- sainiNumberOfWeeksInMonth
    public var sainiNumberOfWeeksInMonth: Int {
        let calendar = Calendar.current
        let weekRange = (calendar as NSCalendar).range(of: NSCalendar.Unit.weekOfYear, in: NSCalendar.Unit.month, for: self)
        
        return weekRange.length
    }
    //MARK:- sainiFormattedDateString
     func sainiFormattedDateString(_ format: SainiFormatter) -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format.rawValue
        
        return dateFormatter.string(from: self)
    }
    
    //MARK: - sainiStampValue
    public func sainiStampValue() -> String
    {
        return String(format: "%0.0f", self.timeIntervalSince1970*1000)
    }

}
