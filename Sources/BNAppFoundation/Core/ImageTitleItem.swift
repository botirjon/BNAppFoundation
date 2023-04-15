//
//  ImageTitleItem.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 22/12/22.
//

import Foundation
import UIKit

public protocol AnyImageTitleItem {
    var title: String? { get }
    var image: UIImage? { get }
}

public struct ImageTitleItem: AnyImageTitleItem {
    public var title: String?
    public var image: UIImage?
    
    public init(title: String? = nil, image: UIImage? = nil) {
        self.title = title
        self.image = image
    }
}



