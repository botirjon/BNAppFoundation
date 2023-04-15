//
//  UIEdgeInsets.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 29/07/22.
//

import UIKit

public extension UIEdgeInsets {
    
    init(y: CGFloat, x: CGFloat) {
        self.init(top: y, left: x, bottom: y, right: x)
    }
    
    static func horizontal(_ inset: CGFloat) -> UIEdgeInsets {
        .init(y: 0, x: inset)
    }
    
    static func vertical(_ inset: CGFloat) -> UIEdgeInsets {
        .init(y: inset, x: 0)
    }
    
    static func vertical(top: CGFloat, bottom: CGFloat) -> UIEdgeInsets {
        .init(top: top, left: 0, bottom: bottom, right: 0)
    }
    
    static func horizontal(left: CGFloat, right: CGFloat) -> UIEdgeInsets {
        .init(top: 0, left: left, bottom: 0, right: right)
    }
    
    static func sameVertical(_ inset: CGFloat, left: CGFloat, right: CGFloat) -> UIEdgeInsets {
        .init(top: inset, left: left, bottom: inset, right: right)
    }
    
    static func sameHorizontal(_ inset: CGFloat, top: CGFloat, bottom: CGFloat) -> UIEdgeInsets {
        .init(top: top, left: inset, bottom: bottom, right: inset)
    }
}
