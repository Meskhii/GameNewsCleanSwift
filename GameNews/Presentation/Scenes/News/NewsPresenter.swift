//
//  NewsPresenter.swift
//  GameNews
//
//  Created by Admin on 15.05.2021.
//

import Foundation

protocol NewsPresentationLogic: AnyObject {
    func present(data: [NewsModel])
}

class NewsPresenter {
    weak var newsViewController: NewsDisplayLogic?
}

extension NewsPresenter: NewsPresentationLogic {
    func present(data: [NewsModel]) {
        var newCellModel = [NewsCellModel]()

        for news in data {
            for index in 0..<news.titles.count {
                newCellModel.append(NewsCellModel(title: news.titles[index],
                                                  imgURL: news.imgUrls[index],
                                                  postTime: news.postTimes[index],
                                                  hrefURL: news.hrefUrls[index],
                                                  isBookmarked: news.isBookmarked[index],
                                                  webPageLogo: news.webPageLogo,
                                                  webPageName: news.webPageName,
                                                  webPageURL: news.webPageUrl))
            }
        }

        newsViewController?.display(data: newCellModel)
    }
}
