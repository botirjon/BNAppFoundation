//
//  StructWrapper.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 21/12/22.
//

import Foundation

public struct StructWrapper<T> {
    public private(set) var base: T
    
    public init(base: T) {
        self.base = base
    }
}
