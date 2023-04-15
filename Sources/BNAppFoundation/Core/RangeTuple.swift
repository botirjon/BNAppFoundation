//
//  RangeTuple.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 12/05/22.
//

import Foundation


public struct RangeTuple<T> {
    
    public var fromValue: T?
    public var toValue: T?
    
    public init(fromValue: T? = nil, toValue: T? = nil) {
        self.fromValue = fromValue
        self.toValue = toValue
    }
    
    public var hasAnyValue: Bool {
        fromValue != nil || toValue != nil
    }
}

extension RangeTuple: Equatable where T: Equatable {
    public static func == (lhs: RangeTuple<T>, rhs: RangeTuple<T>) -> Bool {
        return lhs.fromValue == rhs.fromValue && rhs.toValue == rhs.toValue
    }
}
