//
//  GameInformerManager.swift
//  GameNews
//
//  Created by user200006 on 6/11/21.
//

import Foundation
import SwiftSoup

protocol GameInformerManagerProtocol {
    func fetchNews(completion: @escaping (NewsModel) -> Void)
}

class GameInformerManager: GameInformerManagerProtocol {

    let newsWorker: NewsWorker!

    init() {
        newsWorker = NewsWorker()
    }

    // MARK: - Fetch News
    func fetchNews(completion: @escaping (NewsModel) -> Void) {
        let urlString = "https://www.gameinformer.com/news"

        newsWorker.getGameInformerNews(url: urlString) { (result: Result<NewsModel, Error>) in
            switch result {
            case .success(let news):
                completion(news)
            case .failure(let error):
                print(error)
            }
        }
    }
}
// MARK: - Fetch Logic
extension NewsWorker {

    func fetchLogicForGameInformer(doc: Document, comp: @escaping (NewsModel) -> Void) {

        var gameInformerNewsModel: NewsModel!

        // MARK: - Setup HTML Tags
        do {
            let titles = try doc.getElementsByClass("field field--name-title field--type-string field--label-hidden")
            let times = try doc.getElementsByClass("field field--name-created field--type-created field--label-hidden")
            let items = try doc.getElementsByClass("promo-img-thumb")

            // MARK: - Try Web Scraping
            do {
                var titlesList = [String]()
                var timesList = [String]()
                var imgUrlsList = [String]()
                var hrefsList = [String]()

                for time in times {
                    timesList.append(try time.text())
                }

                for img in items {
                    let tag = try img.select("a")
                    let url = try tag.select("img")
                    let fullImgUrl = "https://www.gameinformer.com/\(try url.attr("src"))"
                    imgUrlsList.append(fullImgUrl)
                }

                for title in titles {
                    let title = try title.text()
                    let titleWithoutLine = title.replacingOccurrences(of: "/", with: "")
                    let secondTitleWithoutLine = titleWithoutLine.replacingOccurrences(of: "\\", with: "")
                    let rightTitle = secondTitleWithoutLine.replacingOccurrences(of: "-", with: "")
                    titlesList.append(rightTitle)
                }

                for href in items {
                    let tag = try href.select("a")

                    hrefsList.append("https://www.gameinformer.com/\(try tag.attr("href"))")

                }

                // MARK: - Prepare Parsed Data

                // drop first useless items
                imgUrlsList.removeFirst()
                hrefsList.removeFirst()

                firebaseManager.checkIfNewsBookmarked(titles: titlesList) { result in
                    gameInformerNewsModel = NewsModel(titles: titlesList,
                                            imgUrls: imgUrlsList,
                                            postTimes: timesList,
                                            hrefUrls: hrefsList,
                                            isBookmarked: result,
                                            webPageLogo: "gameinformer_logo",
                                            webPageName: "Gameinformer",
                                            webPageUrl: "https://www.gameinformer.com/")

                    comp(gameInformerNewsModel)

                }
            } catch {
                print("error")
            }
         } catch {
            print("error")
        }
    }
}
