//
//  KeyValuePair.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 19/08/22.
//

import Foundation

public struct KeyValuePair<Key, Value> {
    
    public var key: Key
    public var value: Value
    
    public init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
    
    public var asTuple: (Key, Value) {
        (key, value)
    }
}


public extension KeyValuePairs {
    init(pairs: [KeyValuePair<Key, Value>]) {
        self.init()
        
    }
}
