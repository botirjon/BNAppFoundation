//
//  KeychainService.swift
//  JOYDA
//
//  Created by botirjon nasridinov on 19.11.2019.
//  Copyright © 2019 SANOAT QURILISH BANK. All rights reserved.
//

import Foundation

public class KeychainService {
    
    public static let shared: KeychainService = KeychainService.init()
    
    private init() {}
    
    @discardableResult
    public func save(value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8, allowLossyConversion: false) else {
            return false
        }
        
        do {
            try delete(valueForKey: key)
        } catch {
            Logger.error("Nothing to delete")
        }
        
        let queryAdd: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key as AnyObject,
            kSecValueData as String: data as AnyObject,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]
        
        let resultCode: OSStatus = SecItemAdd(queryAdd as CFDictionary, nil)
        
        if resultCode != 0 {
            Logger.error("Keychain: value not added - Error: \(resultCode)")
            return false
        } else {
            Logger.info("Keychain: value added successfully")
            return true
        }
        
    }
    
    func getValue(forKey key: String) -> String? {
        do {
            return try query(key: key)
        } catch {
            return nil
        }
    }
    
    func delete(valueForKey key: String) throws {
        let queryDelete: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key as AnyObject
        ]
        
        let resultCodeDelete = SecItemDelete(queryDelete as CFDictionary)
        
        if resultCodeDelete != 0 {
            print("Keychain: unable to delete from keychain: \(resultCodeDelete)")
        } else {
            print("Keychain: successfully deleted item")
        }
    }

    func query(key: String) throws -> String? {
        let queryLoad: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let resultCodeLoad = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(queryLoad as CFDictionary, UnsafeMutablePointer($0))
        }
        
        if resultCodeLoad != 0 {
            Logger.error("Keychain: unable to load data - \(resultCodeLoad)")
            return nil
        }
        
        guard let resultVal = result as? NSData, let keyValue = NSString(data: resultVal as Data, encoding: String.Encoding.utf8.rawValue) as String? else {
            Logger.error("Keychain: error parsing keychain result - \(resultCodeLoad)")
            return nil
        }
        return keyValue
    }
}
