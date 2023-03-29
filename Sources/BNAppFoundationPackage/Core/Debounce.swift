//
//  Debounce.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 06/09/22.
//

import Foundation

public typealias Debounce<T> = (_ : T) -> Void

public func debounce<T>(interval: Double, queue: DispatchQueue, action: @escaping Debounce<T>) -> Debounce<T> {
    var lastFireTime = DispatchTime.now()
    let dispatchDelay = DispatchTimeInterval.milliseconds(Int(interval*1000))
    
    return { param in
        lastFireTime = DispatchTime.now()
        let dispatchTime: DispatchTime = DispatchTime.now() + dispatchDelay
        
        queue.asyncAfter(deadline: dispatchTime) {
            let when: DispatchTime = lastFireTime + dispatchDelay
            let now = DispatchTime.now()
            
            if now.rawValue >= when.rawValue {
                action(param)
            }
        }
    }
}

