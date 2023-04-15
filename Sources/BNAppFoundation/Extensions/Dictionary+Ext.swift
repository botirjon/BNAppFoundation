//
//  Dictionary.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 26/09/22.
//

import Foundation

public extension Dictionary {
    static func += <K, V> (left: inout [K:V], right: [K:V]) {
        for (k, v) in right {
            left[k] = v
        }
    }
}
