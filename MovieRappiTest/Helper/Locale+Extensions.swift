//
//  Locale+Extensions.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/21/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//
import Foundation

extension Locale {
    static var preferredLanguageIdentifier: String {
        let id = Locale.preferredLanguages.first!
        let comps = Locale.components(fromIdentifier: id)
        return comps.values.first!
    }

    static var preferredLanguageLocalizedString: String {
        let id = Locale.preferredLanguages.first!
        return Locale.current.localizedString(forLanguageCode: id)!
    }
}
