//
//  NewsInteractor.swift
//  GameNews
//
//  Created by Admin on 15.05.2021.
//

import Foundation

protocol NewsBusinessLogic {
    func fetchNews(webPageNames: [String])
}

class NewsInteractor {
    var presenter: NewsPresentationLogic?
    var worker = NewsWorker()
    var ignManager: IgnManager!
    var gameInformerManager: GameInformerManager!
    var gamespotManager: GamespotManager!
}

extension NewsInteractor: NewsBusinessLogic {

    func fetchNews(webPageNames: [String]) {
        var fetchedNews = [NewsModel]()
        ignManager = IgnManager()
        gameInformerManager = GameInformerManager()
        gamespotManager = GamespotManager()

        if webPageNames.contains("ign_logo") {
            ignManager.fetchNews { news in
                fetchedNews.append(news)
                DispatchQueue.main.async {
                    self.presenter?.present(data: fetchedNews)
                }
            }
        }

        if webPageNames.contains("gameinformer_logo") {
            gameInformerManager.fetchNews { news in
                fetchedNews.append(news)
                DispatchQueue.main.async {
                    self.presenter?.present(data: fetchedNews)
                }
            }
        }

        if webPageNames.contains("gamespot_logo") {
            gamespotManager.fetchNews { news in
                fetchedNews.append(news)
                DispatchQueue.main.async {
                    self.presenter?.present(data: fetchedNews)
                }
            }
        }

    }

}
