//
//  SteamNewsWorker.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import Foundation
import SwiftSoup

class SteamSearchGameWorker {

    static let shared = SteamSearchGameWorker()

    // MARK: - Search Game
    func searchForGames(searchWord: String, completion: @escaping (SearchResultModel?) -> Void) {
        var searchResultModel: SearchResultModel!
        let steamSearchResultURLString = "https://store.steampowered.com/search/?term=\(searchWord)"

        guard let url = URL(string: steamSearchResultURLString) else {return}

        do {
            let htmlString = try String(contentsOf: url, encoding: .utf8)
            let htmlContent = htmlString

            do {
                let doc = try SwiftSoup.parse(htmlContent)
                searchResultModel = fetchSearchResult(doc: doc)

                completion(searchResultModel)
            }
        } catch {
            completion(nil)
        }
    }
}

extension SteamSearchGameWorker {

    // MARK: - Fetch Search Result
    func fetchSearchResult(doc: Document) -> SearchResultModel? {

        var titlesArray = [String]()
        var releasDateArray = [String]()
        var imgURLSArray = [String]()
        var appIdsArray = [String]()
        var gamePricesArray = [String]()

        do {
            let imgURLS = try doc.select("img")
            let titles = try doc.getElementsByClass("title")
            let releaseDates = try doc.getElementsByClass("col search_released responsive_secondrow")
            let gamePrices = try doc.getElementsByClass("col search_price  responsive_secondrow")

            do {

                for date in releaseDates {
                    let releaseDate = try date.text()
                    if !releaseDate.isEmpty {
                        releasDateArray.append(releaseDate)
                    } else {
                        releasDateArray.append("Coming Soon")
                    }
                }

                for img in imgURLS {
                    let url = try img.attr("src")

                    if url.contains("/apps") {
                        imgURLSArray.append(url)
                        let appId = getSteamGameAppId(from: url)
                        appIdsArray.append(appId)
                    }

                }

                for title in titles {
                    titlesArray.append(try title.text())
                }

                for price in gamePrices {
                    let checkPrice = try price.text()
                    if !checkPrice.isEmpty && checkPrice != "" {
                        gamePricesArray.append(try price.text())
                    } else {
                        gamePricesArray.append("Coming Soon")
                    }
                }

                return SearchResultModel(titles: titlesArray,
                                         imgURLs: imgURLSArray,
                                         appIds: appIdsArray,
                                         releaseDate: releasDateArray,
                                         gamePrices: gamePricesArray)

            } catch {
                return nil
            }
        } catch {
            return nil
        }
    }

    // MARK: - Helper Methods
    func getSteamGameAppId(from stringURL: String) -> String {
        if let range = stringURL.range(of: "apps/") {
            let upperBound = stringURL[range.upperBound...]
            let appId = splitAtFirst(str: String(upperBound), delimiter: "/")
            return appId!
        }
        return ""
    }

    func splitAtFirst(str: String, delimiter: String) -> String? {
        guard let lowerIndex = (str.range(of: delimiter)?.lowerBound) else { return str }
        let firstPart: String = .init(str.prefix(upTo: lowerIndex))
        return firstPart
    }

}
