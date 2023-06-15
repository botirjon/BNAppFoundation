//
//  Array+Ext.swift
//  TELSALE
//
//  Created by Botirjon Nasridinov on 16/02/22.
//

import Foundation

public extension Array {
    
    func isValidIndex(_ index: Int) -> Bool {
        return index >= 0 && index < self.count
    }
    
    func element(at index: Int) -> Element? {
        guard index >= 0 && index < self.count else {
            return nil
        }
        return self[index]
    }
}


public extension Array {
    func insertionIndex(for elem: Element, isOrderedBefore: (Element, Element) -> Bool) -> Int {
        var lo = 0
        var hi = self.count - 1
        while lo <= hi {
            let mid = (lo + hi)/2
            if isOrderedBefore(self[mid], elem) {
                lo = mid + 1
            } else if isOrderedBefore(elem, self[mid]) {
                hi = mid - 1
            } else {
                return mid // found at position mid
            }
        }
        return lo // not found, would be inserted at position lo
    }
}
