//
//  GameSpot.swift
//  GameNews
//
//  Created by Admin on 25.07.2021.
//

import UIKit

class News: NewsCellDataProvider {
    init(with news: NewsCellModel) {
        self.title = news.title
        self.imgURL = news.imgURL
        self.postTime = news.postTime
        self.hrefURL = news.hrefURL
        self.isBookmarked = news.isBookmarked
        self.webPageURL = news.webPageURL
        self.webPageLogo = news.webPageLogo
        self.webPageName = news.webPageName
    }

    let title: String?
    let imgURL: String?
    let postTime: String?
    let hrefURL: String?
    var isBookmarked: Bool?
    let webPageLogo: String?
    let webPageName: String?
    let webPageURL: String?
}
