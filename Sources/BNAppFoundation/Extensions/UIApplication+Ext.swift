//
//  UIApplication+Ext.swift
//  AppDesign
//
//  Created by Botirjon Nasridinov on 17/02/22.
//

import Foundation
import UIKit


public extension UIViewController {
    
    var safeAreaInsets: UIEdgeInsets {
        let supMax = max(tabBarController?.tabBar.bounds.size.height ?? 0, navigationController?.tabBarController?.tabBar.bounds.size.height ?? 0)
        if #available(iOS 11.0, *) {
            let bottom = max(view.safeAreaInsets.bottom, supMax)
            var insets = view.safeAreaInsets
            insets.bottom = bottom
            return insets
        }
        else {
            return .init(top: topLayoutGuide.length,
                         left: 0,
                         bottom: max(bottomLayoutGuide.length, supMax),
                         right: 0)
        }
    }
    
    var safeAreaFrame: CGRect {
        let w = view.bounds.width-safeAreaInsets.left-safeAreaInsets.right
        let h = view.bounds.height-safeAreaInsets.top-safeAreaInsets.bottom
        return .init(x: safeAreaInsets.left, y: safeAreaInsets.top, width: w, height: h)
    }
}
