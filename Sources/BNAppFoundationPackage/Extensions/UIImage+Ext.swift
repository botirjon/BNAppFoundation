//
//  UIImage+Ext.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 02/03/23.
//

import Foundation
import UIKit

public extension UIImage {
    
    func megaBytes() -> Double? {
        guard let imageData = self.jpegData(compressionQuality: 1) else {
            return nil
        }
        let imageSize = imageData.count
        return Double(imageSize)/(1024.0*1024.0)
    }
    
    func compressTo(size: Double) -> Data? {
        guard let mbs = self.megaBytes() else {
            return nil
        }
        if mbs <= size {
            return jpegData(compressionQuality: 1)
        } else {
            return jpegData(compressionQuality: CGFloat(size/mbs))
        }
    }
}
