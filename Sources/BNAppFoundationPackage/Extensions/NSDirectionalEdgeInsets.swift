//
//  NSDirectionalEdgeInsets.swift
//  
//
//  Created by Botirjon Nasridinov on 06/04/23.
//

import Foundation
import UIKit


public extension NSDirectionalEdgeInsets {
    
    init(y: CGFloat, x: CGFloat) {
        self.init(top: y, leading: x, bottom: y, trailing: x)
    }
    
    static func horizontal(_ inset: CGFloat) -> NSDirectionalEdgeInsets {
        .init(y: 0, x: inset)
    }
    
    static func vertical(_ inset: CGFloat) -> NSDirectionalEdgeInsets {
        .init(y: inset, x: 0)
    }
    
    static func vertical(top: CGFloat, bottom: CGFloat) -> NSDirectionalEdgeInsets {
        .init(top: top, leading: 0, bottom: bottom, trailing: 0)
    }
    
    static func horizontal(leading: CGFloat, trailing: CGFloat) -> NSDirectionalEdgeInsets {
        .init(top: 0, leading: leading, bottom: 0, trailing: trailing)
    }
    
    static func sameVertical(_ inset: CGFloat, leading: CGFloat, trailing: CGFloat) -> NSDirectionalEdgeInsets {
        .init(top: inset, leading: leading, bottom: inset, trailing: trailing)
    }
    
    static func sameHorizontal(_ inset: CGFloat, top: CGFloat, bottom: CGFloat) -> NSDirectionalEdgeInsets {
        .init(top: top, leading: inset, bottom: bottom, trailing: inset)
    }
}
