//
//  Digit.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 20/04/22.
//

import Foundation

public enum Digit: Int, CaseIterable {
    case zero = 0
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    
    public var stringValue: String {
        "\(rawValue)"
    }
}
