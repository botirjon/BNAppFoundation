//
//  Pages.swift
//  
//
//  Created by Botirjon Nasridinov on 27/04/23.
//

import Foundation

public class Pages<Item> {
    private var pages: [Int: [Item]] = [:]
    private(set) var all: [Item] = []
    private(set) var startIndex: Int?
    private(set) var endIndex: Int?
    
    
    
    private var observers: [(_ startIndex: Int?, _ endIndex: Int?, _ all: [Item]) -> Void] = []
    
    public func updatePage(_ items: [Item], at index: Int) {
        pages.updateValue(items, forKey: index)
        self.refreshAll()
        startIndex = pages.keys.min()
        endIndex = pages.keys.max()
        
        observers.forEach { (observer) in
            observer(startIndex, endIndex, all)
        }
    }
    
    private func refreshAll() {
        all = []
        all = pages.sorted(by: { (tup1, tup2) -> Bool in
            return tup2.key > tup1.key
        }).reduce(into: all, { (partialResult, tuple) in
            partialResult.append(contentsOf: tuple.value)
        })
    }
    
    public func append(item: Item, into page: Int) {
        if pages[page] == nil {
            pages[page] = []
        }
        pages[page]?.append(item)
    }
    
    public func insert(item: Item, into page: Int, at index: Int) {
        if pages[page] == nil {
            pages[page] = []
        }
        pages[page]?.insert(item, at: index)
    }
    
    public func page(at index: Int) -> [Item] {
        return pages[index] ?? []
    }
    
    public func removePage(at index: Int) {
        self.pages.removeValue(forKey: index)
    }
    
    deinit {
        observers.removeAll()
    }
    
    public func observe(with handler: @escaping (Int?, Int?, [Item]) -> Void) {
        self.observers.append(handler)
    }
    
    public func clear() {
        self.pages = [:]
        self.all = []
        self.pages.removeAll()
        self.all.removeAll()
        self.startIndex = nil
        self.endIndex = nil
    }
    
    public func removeAll(where predicate: (Item) -> Bool) {
        self.pages.forEach { (page, values) in
            self.pages[page]?.removeAll(where: predicate)
        }
        self.refreshAll()
    }
}

