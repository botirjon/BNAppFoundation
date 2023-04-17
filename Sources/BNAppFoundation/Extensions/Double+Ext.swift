//
//  Double+Ext.swift
//  TELSALE
//
//  Created by Botirjon Nasridinov on 25/02/22.
//

import Foundation
import UIKit

public extension Numeric {
    var toString: String {
        "\(self)"
    }
}

public enum DecimalSeparator: String {
    case point = "."
    case comma = ","
}

public extension Double {
    func string(maximumFractionDigits: Int = 2) -> String {
        let s = String(format: "%.\(maximumFractionDigits)f", self)
        var offset = -maximumFractionDigits - 1
        for i in stride(from: 0, to: -maximumFractionDigits, by: -1) {
            if s[s.index(s.endIndex, offsetBy: i - 1)] != "0" {
                offset = i
                break
            }
        }
        return String(s[..<s.index(s.endIndex, offsetBy: offset)])
    }
    
    
    func stringDroppingTrailingZeros() -> String? {
        let string = "\(self)"
        let chunks = string.split(separator: ".").map { String($0) }
        guard chunks.count > 0 && chunks.count <= 2 else { return nil }
        if chunks.count == 1 {
            return chunks.first
        } else if chunks.count == 2 {
            guard var decimals = chunks.last else { return nil }
            while decimals.last == "0" && !decimals.isEmpty {
                decimals.removeLast()
            }
            var newChunks: [String] = [chunks[0]]
            if !decimals.isEmpty {
                newChunks.append(decimals)
            }
            return newChunks.joined(separator: ".")
        } else {
            return nil
        }
    }
}

public extension Double {
    
    func string(withPrecision precision: Int, decimalPoint: String = ",") -> String {
        var str = String.init(format: "%.\(precision)f", self)
        if decimalPoint != "." {
            str = str.replacingOccurrences(of: ".", with: decimalPoint)
        }
        return str
    }
    
    mutating func round(withPrecision precision: Int) {
        let power = pow(10.0, Double(precision))
        self = self * power
        self.round()
        self /= power
    }
    
    func rounded(withPrecision precision: Int) -> Double {
        let power = pow(10.0, Double(precision))
        var new = self * power
        new.round()
        return new/power
    }
    
    func formattedString(groupingSize: Int = 3, separator: String = " ", decimalPoint: String = ",") -> String? {
        let number = NSNumber.init(value: self)
        
        let formatter = NumberFormatter.init()
        formatter.groupingSeparator = separator
        formatter.groupingSize = groupingSize
        formatter.numberStyle = .decimal
        let str = formatter.string(from: number)
        if separator != "." {
            return str?.replacingOccurrences(of: ".", with: ",")
        }
        else {
            let splitted = str?.split(separator: ".") ?? []
            if splitted.count >= 2 {
                let last = String(splitted.last ?? "")
                let allButLast = splitted.dropLast()
                var number = allButLast.joined(separator: ".")
                if !last.isEmpty {
                    number.append(decimalPoint+last)
                }
                return number
            }
            return str
        }
    }
    
    
    /// Generates a formatted string as `1 023 233,23 UZS`. Note that by default the methods divides the original amount by 100 and keeps tiyins.
    /// - Parameters:
    ///   - currency: Currency of the money. By default empty.
    ///   - shouldDivideByHundred: If should divide by hundred. By default true.
    ///   - shouldKeepTiyins: If should keep tiyins. By default true.
    func stringFormattedAsMoneyAmount(currency: String = "", shouldDivideByHundred: Bool = false, shouldKeepTiyins: Bool = true, decimalSeparator: DecimalSeparator = .point, shouldDropTrailingZeros: Bool = false, shouldKeepOneTrailingZero: Bool = false) -> String? {
        
        var amount = shouldDivideByHundred ? self/100 : self
        if !shouldKeepTiyins {
            amount.round()
        }
        else {
            amount.round(withPrecision: 2)
        }
        
        let str = amount.string(withPrecision: 2, decimalPoint: ".")
        
        var splitted = str.split(separator: ".").map { String($0) }
        
        guard splitted.count == 2, let number = Double(splitted[0]) else {
            return nil
        }
        
        let numberString = (number.formattedString() ?? "").trimmingCharacters(in: CharacterSet.init([" "]))
        if !numberString.isEmpty {
            splitted[0] = numberString
        }
        
        var amountString = ""
        if shouldKeepTiyins {
            if shouldDropTrailingZeros {
                while splitted[1].last == "0" {
                    if splitted[1].count == 1 && shouldKeepOneTrailingZero {
                        break
                    } else {
                        splitted[1] = String(splitted[1].dropLast())
                    }
                }
                if !splitted[1].isEmpty {
                    amountString = splitted.joined(separator: decimalSeparator.rawValue)
                } else {
                    amountString = splitted[0]
                }
            } else {
                amountString = splitted.joined(separator: decimalSeparator.rawValue)
            }
        }
        else {
            amountString = splitted[0]
        }
        
        if !amountString.isEmpty, !currency.isEmpty {
            amountString.append(" \(currency)")
        }
        return amountString
    }
}


public extension Int {
    
    /// Generates a formatted string as `1 023 233,23 UZS`. Note that by default the methods divides the original amount by 100 and keeps tiyins.
    /// - Parameters:
    ///   - currency: Currency of the money. By default empty.
    ///   - shouldDivideByHundred: If should divide by hundred. By default true.
    ///   - shouldKeepTiyins: If should keep tiyins. By default true.
    func stringFormattedAsMoneyAmount(currency: String = "", shouldDivideByHundred: Bool = true, shouldKeepTiyins: Bool = true, decimalSeparator: DecimalSeparator = .comma, shouldDropTrailingZeros: Bool = false) -> String? {
        Double(self).stringFormattedAsMoneyAmount(currency: currency, shouldDivideByHundred: shouldDivideByHundred, shouldKeepTiyins: shouldKeepTiyins, decimalSeparator: decimalSeparator, shouldDropTrailingZeros: shouldDropTrailingZeros)
    }
}
