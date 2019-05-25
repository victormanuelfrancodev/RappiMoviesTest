//
//  Bundle+Extensions.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/21/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import Foundation

extension Bundle {
    // Get lozalizable
    static var getLocalizable: NSString {
        return main.preferredLocalizations.first! as NSString
    }
}
