//
//  Group.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 07/05/22.
//

import Foundation

public protocol DateEvent {
    var eventDate: Date? { get }
}

public protocol Groupable {
    var groupIdentifier: Int { get }
}


public class Group<Item, Grouper> {
    public var grouper: Grouper
    public var items: [Item] = []
    
    public init(grouper: Grouper, items: [Item] = []) {
        self.grouper = grouper
        self.items = items
    }
    
    public var count: Int {
        return items.count
    }
    
    public func  item(at index: Int) -> Item? {
        return items.element(at: index)
    }
}

public extension Group where Grouper == Date {
    
    /// Groups items by date.
    /// - Parameter items: Items that are grouped.
    /// - Parameter component: date component by which the items are grouped. Currently only supports `day`, `month` and `year`.
    /// - Parameter isSorted: Hints if the result is sorted.
    static func group<SourceType: DateEvent>(items: [SourceType], by component: Calendar.Component, isSorted: Bool = false, converter convert: ((SourceType) -> Item)? = nil) throws -> [Group<Item, Date>] {
        var _groups: [Date: [SourceType]] = [:]
        try items.forEach {
            if $0.eventDate != nil {
                let dateKey = $0.eventDate!
                var filteredArray = try items.filter { (item) -> Bool in
                    if item.eventDate != nil {
                        switch component {
                        case .day:
                            return dateKey.isSameDay(with: item.eventDate!)
                            
                        case .month:
                            return dateKey.isSameMonth(with: item.eventDate!)
                            
                        case .year:
                            return dateKey.isSameYear(with: item.eventDate!)
                            
                        default:
                            throw NSError.init(domain: "unsupported date component", code: 0, userInfo: nil)
                        }
                    }
                    return false
                }
                if isSorted {
                    filteredArray.sort {
                        if let date1 = $0.eventDate, let date2 = $1.eventDate {
                            return date1.compare(date2) == .orderedDescending
                        }
                        return false
                    }
                }
                
                switch component {
                case .day:
                    if let day = dateKey.day {
                        _groups[day] = filteredArray
                    }
                    
                case .month:
                    if let month = dateKey.month {
                        _groups[month] = filteredArray
                    }
                    
                case .year:
                    if let year = dateKey.year {
                        _groups[year] = filteredArray
                    }
                    
                default:
                    throw NSError.init(domain: "unsupported date component", code: 0, userInfo: nil)
                }
            }
        }
        
        var groups: [Group<Item, Date>] = []
        _groups.forEach { (date, _items) in
            let g = Group<Item, Grouper>.init(grouper: date)
            if SourceType.self == Item.self {
                g.items = _items as! [Item]
            }
            else {
                g.items = _items.compactMap({ (item) -> Item? in
                    return convert?(item)
                })
            }
            groups.append(g)
        }
        
        if isSorted {
            groups.sort { (g1, g2) -> Bool in
                return g1.grouper.compare(g2.grouper) == .orderedDescending
            }
        }
        
        return groups
    }
}


public extension Group where Grouper == Int {
    
    /// Groups items by date.
    /// - Parameter items: Items that are grouped.
    /// - Parameter component: date component by which the items are grouped. Currently only supports `day`, `month` and `year`.
    /// - Parameter isSorted: Hints if the result is sorted.
    static func group<SourceType: Groupable>(items: [SourceType], isSorted: Bool = false, converter convert: ((SourceType) -> Item)? = nil) throws -> [Group<Item, Int>] {
        
        var _groups: [Int: [SourceType]] = [:]
        var mutableList: [SourceType] = items
        
        items.forEach {
            
            let groupID = $0.groupIdentifier
            
            if !_groups.keys.contains(groupID) {
                let separated = mutableList.separate { groupID == $0.groupIdentifier }
                
                var matching = separated.matching
                
                mutableList = separated.notMatching
                
                if isSorted {
                    matching = matching.sorted(by: { item1, item2 in
                        return item1.groupIdentifier > item2.groupIdentifier
                    })
                }
                
                _groups[groupID] = matching
            }
        }
        
        var groups: [Group<Item, Int>] = []
        _groups.forEach { (date, _items) in
            let g = Group<Item, Grouper>.init(grouper: date)
            if SourceType.self == Item.self {
                g.items = _items as! [Item]
            }
            else {
                g.items = _items.compactMap({ (item) -> Item? in
                    return convert?(item)
                })
            }
            groups.append(g)
        }
        
        if isSorted {
            groups.sort { (g1, g2) -> Bool in
                return g1.grouper < g2.grouper
            }
        }
        
        return groups
    }
}



public extension Collection {
    func separate(predicate: (Iterator.Element) -> Bool) -> (matching: [Iterator.Element], notMatching: [Iterator.Element]) {
        var groups: ([Iterator.Element],[Iterator.Element]) = ([],[])
        for element in self {
            if predicate(element) {
                groups.0.append(element)
            } else {
                groups.1.append(element)
            }
        }
        return groups
    }
}

/*
 
 CLASS: deposits
 
 {{domain}}/api/mobile/v1/deposits
 
 // Ваши депозиты
 GET {{domain}}/api/mobile/v1/deposits/mine/list
 
 // Детали депозита
 GET {{domain}}/api/mobile/v1/deposits/mine/details?id={{deposit_id}}
 
 // Выписка депозита
 GET {{domain}}/api/mobile/v1/deposits/mine/statement?id={{deposit_id}}

 // Реквизиты
 GET {{domain}}/api/mobile/v1/deposits/mine/requisites?id={{deposit_id}}
 
 // Действие с депозитом
 
 // Вложение денег
 POST {{domain}}/api/mobile/v1/deposits/mine/attach-money
 PARAMS: {
    "amount": double, // сумма вложение
    "receipt_number": int, // номер квитанции
    "debit_account": string // счет списания
    "date": string
 }
 
 POST {{domain}}/api/mobile/v1/deposits/mine/partial-withdraw
 
 
 
 
 POST {{domain}}/api/mobile/v1/deposits/mine/partial-early-withdraw
 
 GET {{domain}}/api/mobile/v1/deposits/product/list
 GET {{domain}}/api/mobile/v1/deposits/product/list
 
 */
