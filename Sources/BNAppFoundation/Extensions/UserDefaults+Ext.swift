//
//  UserDefaults+Ext.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 01/04/22.
//

import Foundation

public protocol UserDefaultsKeyProtocol {
    var rawValue: String { get }
}


public extension UserDefaults {
    
    func saveObject<Object: Codable>(_ object: Object?, forKey key: String) throws {
        guard let object = object else {
            self.setValue(nil, forKey: key)
            return
        }
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(object)
        self.set(encoded, forKey: key)
    }
    
    func getObject<Object: Codable>(_ type: Object.Type, forKey key: String) -> Object? {
        guard let savedObject = self.value(forKey: key) as? Data else {
            return nil
        }
        let decoder = JSONDecoder()
        return try? decoder.decode(Object.self, from: savedObject)
    }
    
//    func saveObject<Object: Codable>(_ object: Object?, forKey key: String) {
//        if object == nil {
//            self.setValue(nil, forKey: key.rawValue)
//            return
//        }
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(object) {
//            self.set(encoded, forKey: key.rawValue)
//        }
//    }
//
//    func getObject<Object: Codable>(_ type: Object.Type, forKey key: UserDefaultsKeyProtocol) -> Object? {
//        guard let savedObject = self.value(forKey: key.rawValue) as? Data else {
//            return nil
//        }
//        let decoder = JSONDecoder()
//        return try? decoder.decode(Object.self, from: savedObject)
//    }
}
