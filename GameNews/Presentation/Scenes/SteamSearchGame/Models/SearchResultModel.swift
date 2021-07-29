//
//  SearchResultModel.swift
//  GameNews
//
//  Created by Admin on 07.06.2021.
//

import Foundation

struct SearchResultModel: Codable {
    let titles: [String]
    let imgURLs: [String]
    let appIds: [String]
    let releaseDate: [String]
    let gamePrices: [String]
}
