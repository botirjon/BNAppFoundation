//
//  Bool+Ext.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 17/08/22.
//

import Foundation

infix operator ||=
public func ||=(lhs: inout Bool, rhs: Bool) {
    lhs = lhs || rhs
}

infix operator &&=
public func &&=(lhs: inout Bool, rhs: Bool) {
    lhs = lhs && rhs
}
