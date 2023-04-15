//
//  Flaggable.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 15/09/22.
//

import Combine

public class Flaggable<T> {
    public private(set) var object: T
    public var flag: Bool
    
    public init(object: T, flag: Bool = false) {
        self.object = object
        self.flag = flag
    }
    
    public func accept(object: T) {
        self.object = object
    }
}
