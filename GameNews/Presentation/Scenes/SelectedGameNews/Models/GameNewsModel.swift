//
//  GameNewsModel.swift
//  GameNews
//
//  Created by Admin on 08.06.2021.
//

import Foundation

struct GameNewsAppNewsModel: Codable {
    let appnews: GameNewsItemModel
}

struct GameNewsItemModel: Codable {
    let newsitems: [GameNewsModel]
}

struct GameNewsModel: Codable {
    let title: String?
    let url: String?
    let author: String?
    let contents: String?
}
