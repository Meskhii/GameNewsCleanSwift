//
//  IgnManager.swift
//  GameNews
//
//  Created by Admin on 05.06.2021.
//

import Foundation
import SwiftSoup

protocol IgnManagerProtocol {
    func fetchNews(completion: @escaping (NewsModel) -> Void)
}

class IgnManager: IgnManagerProtocol {

    let newsWorker: NewsWorker!

    init() {
        newsWorker = NewsWorker()
    }

    // MARK: - Fetch News
    func fetchNews(completion: @escaping (NewsModel) -> Void) {
        let urlString = "https://www.ign.com/pc?filter=articles"

        newsWorker.getIgnNews(url: urlString) { (result: Result<NewsModel, Error>) in
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

    func fetchLogicForIgn(doc: Document, comp: @escaping (NewsModel) -> Void) {

        var ignNewsModel: NewsModel!

        // MARK: - Setup HTML Tags
        do {
            let timeAgos = try doc.getElementsByClass("item-timeago")
            let imgURLS = try doc.select("img")
            let items = try doc.getElementsByClass("item-body")

            // MARK: - Try Web Scraping
            do {
                var titlesList = [String]()
                var timeAgosList = [String]()
                var imgUrlsList = [String]()
                var hrefsList = [String]()

                for time in timeAgos {
                    timeAgosList.append(try time.text())
                }

                for img in imgURLS {
                    let url = try img.attr("src")
                    let separatedByQuestionMark = splitAtFirst(str: url, delimiter: "?")
                    let parsed = separatedByQuestionMark?.replacingOccurrences(of: "_160w", with: "")
                    imgUrlsList.append(parsed ?? "")
                }

                for title in items {
                    let title = try title.attr("aria-label")
                    let titleWithoutLine = title.replacingOccurrences(of: "/", with: "")
                    let secondTitleWithoutLine = titleWithoutLine.replacingOccurrences(of: "\\", with: "")
                    let rightTitle = secondTitleWithoutLine.replacingOccurrences(of: "-", with: "")
                    titlesList.append(rightTitle)
                }

                for href in items {
                    hrefsList.append("https://www.ign.com/\(try href.attr("href"))")
                }
                // MARK: - Prepare Parsed Data

                // Removing extra fetched data
                // Sometimes there is extra data
                timeAgosList.removeSubrange(0...4)

                imgUrlsList.removeSubrange(0...1)

                titlesList.sort()

                firebaseManager.checkIfNewsBookmarked(titles: titlesList) { result in
                    ignNewsModel = NewsModel(titles: titlesList,
                                            imgUrls: imgUrlsList,
                                            postTimes: timeAgosList,
                                            hrefUrls: hrefsList,
                                            isBookmarked: result,
                                            webPageLogo: "ign_logo",
                                            webPageName: "IGN News",
                                            webPageUrl: "https://www.ign.com/")

                    comp(ignNewsModel)

                }

            } catch {
                print("error")
            }
         } catch {
            print("error")
        }
    }

    // MARK: - Helper Methods
    private func splitAtFirst(str: String, delimiter: String) -> String? {
        guard let lowerIndex = (str.range(of: delimiter)?.lowerBound) else { return str }
        let firstPart: String = .init(str.prefix(upTo: lowerIndex))
        return firstPart
    }
}
