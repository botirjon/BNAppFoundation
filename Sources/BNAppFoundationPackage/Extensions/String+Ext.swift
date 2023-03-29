//
//  String+Ext.swift
//  TELSALE
//
//  Created by Botirjon Nasridinov on 17/02/22.
//

import Foundation
import UIKit


public extension String {
    
    var nsString: NSString {
        NSString(string: self)
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: self, comment: "")
    }
    
    var removingWhiteSpaces: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    var isOnlyDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet.init(charactersIn: self))
    }
    
    var numberSuffix5: String {
        if count >= 5 {
            return "**\(self.suffix(5))"
        }
        return self
    }
    
    var numberSuffix4: String {
        if count >= 4 {
            return "**\(self.suffix(4))"
        }
        return self
    }
    
    var maskedCardNumber: String {
        guard self.isOnlyDigits else { return "" }
        let cleanValue = self.removingWhiteSpaces
        guard cleanValue.count == 16 else { return "" }
        let prefix4 = cleanValue.prefix(4)
        let suffix4 = cleanValue.suffix(4)
        let partialValue = cleanValue.dropLast(4)
        let suffix2 = partialValue.suffix(2)
        
        return "\(prefix4) **\(suffix2) \(suffix4)"
    }
}

public extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}


public extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}


public extension String {
    func attributedString(adding attributes: [NSAttributedString.Key: Any] = [:]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString.init(string: self, attributes: attributes)
        return attributedString
    }
    
    func attributedString(adding attributes: [NSAttributedString.Key: Any], to substring: String) -> NSAttributedString {
        let range = NSString(string: self).range(of: substring)
        let attributedString = NSMutableAttributedString.init(string: self)
        attributedString.addAttributes(attributes, range: range)
        return attributedString
    }
}


public extension String {
    static func randomAlphanumericString(length: Int) -> String  {
        enum Statics {
            static let scalars = [UnicodeScalar("a").value...UnicodeScalar("z").value,
                                  UnicodeScalar("A").value...UnicodeScalar("Z").value,
                                  UnicodeScalar("0").value...UnicodeScalar("9").value].joined()
            
            static let characters = scalars.map { Character(UnicodeScalar($0)!) }
        }
        
        let result = (0..<length).map { _ in Statics.characters.randomElement()! }
        return String(result)
    }
    
    static func randomNumericString(length: Int) -> String  {
        enum Statics {
            static let scalars = [
                                  UnicodeScalar("0").value...UnicodeScalar("9").value].joined()
            
            static let characters = scalars.map { Character(UnicodeScalar($0)!) }
        }
        
        let result = (0..<length).map { _ in Statics.characters.randomElement()! }
        return String(result)
    }
}


public extension String {
    func formattedAsNumber(max: Double? = nil) -> String? {
        var cleanValue = self.replacingOccurrences(of: " ", with: "")
        cleanValue = self.replacingOccurrences(of: ",", with: ".")
        
        var trailer: String = ""
        
        if cleanValue.hasSuffix(".") {
            trailer = "."
            cleanValue = String(cleanValue.dropLast())
        }
        
        guard let doubleValue = Double(cleanValue) else { return nil }
        
        if let max = max {
            guard doubleValue <= Double(max) else {
                return nil
            }
        }
        
        let splitted = cleanValue.split(separator: ".").map { String($0) }
        
        var integer: String = ""
        var decimal: String = ""
        
        if splitted.count == 1 {
            integer = splitted[0]
        } else if splitted.count == 2 {
            integer = splitted[0]
            decimal = splitted[1]
            decimal = String(decimal.prefix(2))
        } else {
            return nil
        }
        
        guard let number = Double(integer), let formattedInterger = number.formattedString(), !formattedInterger.isEmpty else { return nil }
        
        var chunks: [String] = [formattedInterger]
        if !decimal.isEmpty {
            chunks.append(decimal)
        }
        
        if chunks.count == 1 {
            return chunks[0].appending(trailer)
        } else {
            return chunks.joined(separator: ".")
        }
    }
}

public extension String {
    var snakeCased: String? {
        let pattern = "([a-z0-9])([A-Z])"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased()
    }
    
    var camelCased: String {
        return self.lowercased()
            .split(separator: "_")
            .enumerated()
            .map { $0.element.capitalized }
            .joined(separator: "")
    }
    
    var asMaskedCardNumber: String{
        let cleanNumber = self.removingWhiteSpaces
        guard cleanNumber.count == 16 else {
            return self
        }
        return String(format: "%@ **** **** %@", String(cleanNumber.prefix(4)), String(cleanNumber.suffix(4)))
    }
    
    var maskedAccountNumber: String {
        guard self.count > 10 else { return self }
        let p = self.prefix(5)
        let s = self.suffix(5)
        return "\(p) ** \(s)"
    }
}

public extension String {
    
    var digits: String {
        self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    }
}


public extension String {
    
    func isValidPhoneNumber() -> Bool {
        return internationalUzbPhoneNumber().count == 12
    }
    
    func internationalUzbPhoneNumber(hasPlus: Bool = false) -> String {
        let cleanValue = self.digits
        if cleanValue.count == 12 { // Its already in international format
            if cleanValue.hasPrefix("998") {
                var phone = String(cleanValue.prefix(12))
                if hasPlus {
                    phone = "+" + phone
                }
                return phone
            }
        } else if cleanValue.count == 9 {
            var phone = String("998\(cleanValue)".prefix(12))
            if hasPlus {
                phone = "+" + phone
            }
            return phone
        }
        return ""
    }
    
    func internationalPhoneNumber(withMask mask: String? = nil) -> String {
        guard let mask = mask else {
            return self
        }

        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
        
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                
                // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}

public extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,3})$", options: .caseInsensitive)
        let valid = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        return valid
    }
    
    // vrify Valid PhoneNumber or Not
    func isValidPhone(numberOfDigits: Int = 9) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[0-9]{\(numberOfDigits)}$", options: .caseInsensitive)
        let valid = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        return valid
    }
}


public extension Optional where Wrapped == String {
    var safelyUnwrapped: Wrapped {
        switch self {
        case .none:
            return ""
        case .some(let wrapped):
            return wrapped
        }
    }
}

public extension Optional where Wrapped == Array<Any> {
    var safelyUnwrapped: Wrapped {
        switch self {
        case .none:
            return []
        case .some(let wrapped):
            return wrapped
        }
    }
}
