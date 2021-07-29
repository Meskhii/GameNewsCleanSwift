//
//  News+AppCellDataProvider.swift
//  GameNews
//
//  Created by Admin on 25.07.2021.
//

import Foundation

extension News: AppCellDataProvider {
    var identifierCell: String {
        if webPageLogo == "gamespot_logo" {
            return GamespotNewsCell.identifierValue
        } else if webPageLogo == "ign_logo" {
            return IgnNewsCell.identifierValue
        } else if webPageLogo == "gameinformer_logo" {
            return GameInformerNewsCell.identifierValue
        }
        return IgnNewsCell.identifierValue
    }
}
