//
//  Watchable.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 15/09/22.
//

import Foundation

public class Watchable<T> {
    
    private var watchers: [(T) -> Void] = []
    
    private var _value: T {
        didSet {
            broadcast()
        }
    }
    
    public var value: T {
        return _value
    }
    
    public init(value: T) {
        self._value = value
    }
    
    public func accept(value: T) {
        self._value = value
    }
    
    public func watch(onChanges handle: @escaping (T) -> Void) {
        self.watchers.append(handle)
    }
    
    func broadcast() {
        self.watchers.forEach { (handle) in
            handle(_value)
        }
    }
    
    deinit {
        watchers.removeAll()
    }
}
