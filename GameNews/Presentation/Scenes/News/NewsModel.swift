//
//  NewsModel.swift
//  GameNews
//
//  Created by Admin on 04.06.2021.
//

import Foundation

struct NewsModel: Codable {
    let titles: [String]
    let imgUrls: [String]
    let postTimes: [String]
    let hrefUrls: [String]
    let isBookmarked: [Bool]
    let webPageLogo: String
    let webPageName: String
    let webPageUrl: String
}
