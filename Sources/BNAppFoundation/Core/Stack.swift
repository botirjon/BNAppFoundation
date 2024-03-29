//
//  Stack.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 21/04/22.
//

import Foundation

public struct Stack<T> {
    
    public private(set) var items: [T] = []
    
    public func count() -> Int { return items.count }
    
    public func isEmpty() -> Bool { return items.isEmpty }
    
    public init(items: [T] = []) {
        self.items = items
    }
    
    public func peek() -> T? {
        return items.last
    }
    
    
    /// Inserts `item` in the stack at `index`.
    /// - Parameters:
    ///   - item: Item to insert.
    ///   - index: Index at which to insert the item.
    public mutating func insert(_ item: T, at index: Int) {
        self.items.insert(item, at: index)
    }
    
    @discardableResult
    public mutating func pop() -> T? {
        guard !items.isEmpty else { return nil }
        return items.removeLast()
    }
    
    public mutating func push(_ item: T) {
        items.append(item)
    }
    
    public mutating func removeAll() {
        items.removeAll()
    }
    
    public func item(at index: Int) -> T? {
        guard index >= 0 && index < items.count else { return nil }
        return items[index]
    }
}
