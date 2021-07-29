//
//  SteamNewsInteractor.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import Foundation

protocol SteamSearchGameBusinessLogic {
    func fetchSearchedGames(by name: String)
}

class SteamSearchGameInteractor {
    var presenter: SteamSearchGamePresentationLogic?
}

extension SteamSearchGameInteractor: SteamSearchGameBusinessLogic {
    func fetchSearchedGames(by name: String) {
        var fetchedSearchResults: SearchResultModel?

        SteamSearchGameWorker.shared.searchForGames(searchWord: name) {searchResult in
            fetchedSearchResults = searchResult
        }

        if let searchResults = fetchedSearchResults {
            presenter?.presentSearchResult(with: searchResults)
        }
    }
}
