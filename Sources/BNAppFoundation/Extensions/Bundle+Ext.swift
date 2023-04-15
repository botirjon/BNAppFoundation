//
//  Bundle+Ext.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 01/04/22.
//

import Foundation

public extension Bundle {
    
    var appVersion: String {
        let dictionary = Bundle.main.infoDictionary
        let kVersion = "CFBundleShortVersionString"
        guard let version = dictionary?[kVersion] as? String else { return "" }
        return version
    }
    
    var appBuild: String {
        let dictionary = Bundle.main.infoDictionary
        let kBuild = "CFBundleVersion"
        guard let build = dictionary?[kBuild] as? String else { return  ""}
        return build
    }
    
}
