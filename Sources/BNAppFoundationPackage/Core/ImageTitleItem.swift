//
//  ImageTitleItem.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 22/12/22.
//

import Foundation
import UIKit

public struct ImageTitleItem {
    public var title: String?
    public var image: UIImage?
    
    public init(title: String? = nil, image: UIImage? = nil) {
        self.title = title
        self.image = image
    }
}
