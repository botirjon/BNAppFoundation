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
