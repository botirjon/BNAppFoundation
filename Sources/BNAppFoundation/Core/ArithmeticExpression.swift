//
//  ArithmeticExpression.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 14/12/22.
//

import Foundation

public struct ArithmeticExpression {
    public var expression: String
    
    public init(expression: String) {
        self.expression = expression
    }
    
    public func evaluate() -> Int {
        return 0
    }
}

public extension ArithmeticExpression {
    enum Operator: Character, CaseIterable {
        case multiplication = "*"
        case division = "/"
        case addition = "+"
        case subtraction = "-"
        case power = "^"
        
        var precedence: Int {
            switch self {
            case .addition, .subtraction:
                return 1
            case .multiplication, .division:
                return 2
            case .power:
                return 3
            }
        }
        
        static func isOperator(_ char: Character) -> Bool {
            return Operator(rawValue: char) != nil
        }
    }
}


extension Character {
    var isDigit: Bool {
        let stringValue = String(self)
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet.init(charactersIn: stringValue))
    }
}
