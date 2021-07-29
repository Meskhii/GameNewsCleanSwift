//
//  AppTableViewCellIdentifier.swift
//  GameNews
//
//  Created by Admin on 25.07.2021.
//

import Foundation

enum AppTableViewCellIdentifier: String {
    case ignNews
    case gamespotNews
    case gameInformerNews
}

extension AppTableViewCellIdentifier: Identifierable {
    var identifierCell: String {
        return rawValue
    }
}
