//
//  Searchable.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 09/09/22.
//

import Foundation

public protocol Searchable {
    func isMatch(forQuery query: String) -> Bool
}


public extension Array where Element : Searchable {
    
    func filter(byQuery query: String) -> [Element] {
        return self.filter { $0.isMatch(forQuery: query)
        }
    }
}
