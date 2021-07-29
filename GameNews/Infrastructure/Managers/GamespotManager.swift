//
//  GamespotManager.swift
//  GameNews
//
//  Created by user200006 on 6/12/21.
//

import Foundation
import SwiftSoup

protocol GamespotManagerProtocol {
    func fetchNews(completion: @escaping (NewsModel) -> Void)
}

class GamespotManager: GamespotManagerProtocol {

    let newsWorker: NewsWorker!

    init() {
        newsWorker = NewsWorker()
    }

    // MARK: - Fetch News
    func fetchNews(completion: @escaping (NewsModel) -> Void) {
        let urlString = "https://www.gamespot.com/news/"

        newsWorker.getGamespotNews(url: urlString) { (result: Result<NewsModel, Error>) in
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

    func fetchLogicForGamespot(doc: Document, comp: @escaping (NewsModel) -> Void) {

        var gamespotNewsModel: NewsModel!

        // MARK: - Setup HTML Tags
        do {
            let titles = try doc.getElementsByClass("card-item__title ")
            let times = try doc.getElementsByClass("card-metadata ")
            let imgURLS = try doc.getElementsByClass("card-item__img overflow--hidden card-image-overlay order--one card-item__img--margin-right ")
            let items = try doc.getElementsByClass("card-item card-item--horizontal width-100 flexbox-row flexbox-align-center border-bottom-grayscale--thin ")

            // MARK: - Try Web Scraping
            do {
                var titlesList = [String]()
                var timesList = [String]()
                var imgUrlsList = [String]()
                var hrefsList = [String]()

                for time in times {
                    let tag = try time.select("time")
                    timesList.append(try tag.text())
                }

                for img in imgURLS {
                    let tag = try img.select("img")
                    let fullImgUrl = try tag.attr("src")
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
                    let url = try href.select("a")
                    let fullUrl = "https://www.gamespot.com/\(try url.attr("href"))"
                    hrefsList.append(fullUrl)
                }

                // MARK: - Prepare Parsed Data
                firebaseManager.checkIfNewsBookmarked(titles: titlesList) { result in
                    gamespotNewsModel = NewsModel(titles: titlesList,
                                            imgUrls: imgUrlsList,
                                            postTimes: timesList,
                                            hrefUrls: hrefsList,
                                            isBookmarked: result,
                                            webPageLogo: "gamespot_logo",
                                            webPageName: "Gamespot",
                                            webPageUrl: "https://www.gamespot.com/news/")

                    comp(gamespotNewsModel)

                }
            } catch {
                print("error")
            }
         } catch {
            print("error")
        }
    }
}
