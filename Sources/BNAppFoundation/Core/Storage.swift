//
//  Storage.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 05/04/22.
//

import Foundation

public protocol StorageKey {
    var value: String { get }
}

public class Storage {
    public static let shared: Storage = Storage.init()
    private init() {}
    
    private let defaults = UserDefaults.standard
    
    public func set(_ value: Any?, forKey key: StorageKey) {
        defaults.set(value, forKey: key.value)
    }
    
    public func value(forKey key: StorageKey) -> Any? {
        defaults.value(forKey: key.value)
    }
    
    public func bool(forKey key: StorageKey) -> Bool {
        defaults.bool(forKey: key.value)
    }
    
    public func string(forKey key: StorageKey) -> String? {
        defaults.string(forKey: key.value)
    }
    
    public func array(forKey key: StorageKey) -> [Any]? {
        defaults.array(forKey: key.value)
    }
    
    //
    
    public func save(data: Data, forKey key: String) {
        defaults.setValue(data, forKey: key)
    }
    
    public func getData(forKey key: String) -> Data? {
        defaults.data(forKey: key)
    }
    
    public func save(string: String, forKey key: String) {
        defaults.setValue(string, forKey: key)
    }
    
    public func getString(forKey key: String) -> String? {
        defaults.string(forKey: key)
    }
    
    public func save(stringArray: [String], forKey key: String) {
        defaults.setValue(stringArray, forKey: key)
    }
    
    public func getStringArray(forKey key: String) -> [String]? {
        defaults.array(forKey: key) as? [String]
    }
    
    public func save<T: CustomDataConvertible>(value: T, forKey key: StorageKey) {
        defaults.setValue(value.data, forKey: key.value)
    }
    
    public func getValue<T: CustomDataConvertible>(forKey key: StorageKey) -> T? {
        guard let data = defaults.value(forKey: key.value) as? Data else {
            return nil
        }
        return T.from(data: data)
    }
    
    public func deleteValue(forKey key: StorageKey) {
        defaults.setValue(nil, forKey: key.value)
    }
}

extension String: CustomDataConvertible {
    public typealias T = String
    
    public var data: Data? {
        return data(using: .utf8)
    }
    
    public static func from<T>(data: Data) -> T? {
        return String.init(bytes: data, encoding: .utf8) as? T
    }
}

