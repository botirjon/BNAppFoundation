//
//  Date+Ext.swift
//  TELSALE
//
//  Created by Botirjon Nasridinov on 17/02/22.
//

import Foundation

public extension Date {
    
    static var currentYear: Int {
        Calendar.current.component(.year, from: Date())
    }
    
    func string(withDateFormat format: String, locale: Locale? = .init(identifier: "ru")) -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = format
        if let unwrappedLocale = locale {
            dateFormatter.locale = unwrappedLocale
        }
        return dateFormatter.string(from: self)
    }
    
    static func from(string: String, dateFormat: String, locale: Locale? = .init(identifier: "ru")) -> Date? {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat
        if let unwrappedLocale = locale {
            dateFormatter.locale = unwrappedLocale
        }
        return dateFormatter.date(from: string)
    }
    
    init?(string: String, dateFormat: String, locale: Locale? = .init(identifier: "ru")) {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat
        if let unwrappedLocale = locale {
            dateFormatter.locale = unwrappedLocale
        }
        self = dateFormatter.date(from: string)!
    }
}


public extension Date {
    func isSameDay(with date: Date) -> Bool {
        let selfDay = Calendar.current.component(.day, from: self)
        let day = Calendar.current.component(.day, from: date)
        return selfDay == day && isSameMonth(with: date)
    }
    
    func isSameMonth(with date: Date) -> Bool {
        let selfMonth = Calendar.current.component(.month, from: self)
        let month = Calendar.current.component(.month, from: date)
        return selfMonth == month && isSameYear(with: date)
    }
    
    func isSameYear(with date: Date) -> Bool {
        let selfYear = Calendar.current.component(.year, from: self)
        let year = Calendar.current.component(.year, from: date)
        return selfYear == year
    }
    
    static func groupDates(_ dates: [Date], isSorted: Bool = false) -> [Date: [Date]] {
        var groups: [Date: [Date]] = [:]
        dates.forEach {
            let dateKey = $0
            var filterArray = dates.filter { dateKey.isSameDay(with: $0) }
            if isSorted {
                filterArray.sort { $0.compare($1) == .orderedAscending }
            }
            groups[$0] = filterArray
        }
        return groups
    }
    
    var isToday: Bool {
        return isSameDay(with: Date())
    }
    
    var isYesterday: Bool {
        guard let yesterday = Calendar.current.date(byAdding: DateComponents.init(day: -1), to: Date()) else {
            return false
        }
        return isSameDay(with: yesterday)
    }
    
    var isTomorrow: Bool {
        guard let tomorrow = Calendar.current.date(byAdding: DateComponents.init(day: 1), to: Date()) else {
            return false
        }
        return isSameDay(with: tomorrow)
    }
    
    func date(byAddingDays days: Int) -> Date? {
        return Calendar.current.date(byAdding: DateComponents.init(day: days), to: self)
    }
    
    var previousDay: Date? {
        return self.date(byAddingDays: -1)
    }
    
    var nextDay: Date? {
        return self.date(byAddingDays: 1)
    }
    
    var startOfMonth: Date? {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        let startOfMonth = Calendar.current.date(from: components)
        return startOfMonth
    }
    
    var endOfMonth: Date? {
        let components = DateComponents.init(month: 1, day: -1)
        let endOfMonth = Calendar.current.date(byAdding: components, to: self)
        return endOfMonth
    }
    
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    var startOfYear: Date? {
        let year = Calendar.current.component(.year, from: self)
        return Calendar.current.date(from: DateComponents.init(year: year))
    }
    
    var endOfYear: Date? {
        guard let nextYear = Calendar.current.date(byAdding: DateComponents.init(year: 1), to: self) else {
            return nil
        }
        return Calendar.current.date(byAdding: DateComponents.init(day: -1), to: nextYear)
    }
    
    var day: Date? {
        let day = Calendar.current.component(.day, from: self)
        let month = Calendar.current.component(.month, from: self)
        let year = Calendar.current.component(.year, from: self)
        let components = DateComponents.init(year: year, month: month, day: day)
        let newDate = Calendar.current.date(from: components)
        return newDate
    }
    
    var month: Date? {
        let month = Calendar.current.component(.month, from: self)
        let year = Calendar.current.component(.year, from: self)
        let components = DateComponents.init(year: year, month: month)
        let newDate = Calendar.current.date(from: components)
        return newDate
    }
    
    var year: Date? {
        let year = Calendar.current.component(.year, from: self)
        let components = DateComponents.init(year: year)
        let newDate = Calendar.current.date(from: components)
        return newDate
    }
    
    func back(days: Int) -> Date? {
        let components = DateComponents.init(day: -days)
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    func back(months: Int) -> Date? {
        let components = DateComponents.init(month: -months)
        let patch = DateComponents.init(day: 1)
        if let date = Calendar.current.date(byAdding: components, to: self) {
            return Calendar.current.date(byAdding: patch, to: date)
        }
        return nil
    }
    
    func back(years: Int) -> Date? {
        let components = DateComponents.init(year: -years)
        let patch = DateComponents.init(day: 1)
        if let date = Calendar.current.date(byAdding: components, to: self) {
            return Calendar.current.date(byAdding: patch, to: date)
        }
        return nil
    }
}

public extension Date {
    
    static func random(in range: ClosedRange<Date>) -> Date {
        Date(
            timeIntervalSinceNow: .random(
                in: range.lowerBound.timeIntervalSinceNow...range.upperBound.timeIntervalSinceNow
            )
        )
    }
}
