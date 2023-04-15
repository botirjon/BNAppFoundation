//
//  NetworkStated.swift
//  
//
//  Created by Botirjon Nasridinov on 15/04/23.
//

import Foundation

public enum NetworkStated<T> {
    case ready(T)
    case loading
    case failed(_ reason: String)
    case none
}
