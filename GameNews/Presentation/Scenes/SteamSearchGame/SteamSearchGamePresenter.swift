//
//  SteamNewsPresenter.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import Foundation

protocol SteamSearchGamePresentationLogic: AnyObject {
    func presentSearchResult(with data: SearchResultModel)
}

class SteamSearchGamePresenter {
    weak var steamSearchGameViewController: SteamSearchGameDisplayLogic?
}

extension SteamSearchGamePresenter: SteamSearchGamePresentationLogic {
    func presentSearchResult(with data: SearchResultModel) {
        var searchResultCellModel = [SearchResultCellModel]()

        for index in 0..<data.titles.count {

            if index < 20 {
                searchResultCellModel.append(SearchResultCellModel(title: data.titles[index],
                                                                   imgURL: data.imgURLs[index],
                                                                   appId: data.appIds[index],
                                                                   releaseDate: data.releaseDate[index],
                                                                   gamePrice: data.gamePrices[index]))
            } else {
                steamSearchGameViewController?.displaySearchResult(with: searchResultCellModel)
            }
        }
    }
}
