//
//  CustomDataConvertible.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 05/04/22.
//

import Foundation

public protocol CustomDataConvertible {
    associatedtype T
    var data: Data? { get }
    static func from<T>(data: Data) -> T?
}

