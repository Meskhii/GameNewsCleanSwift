//
//  SelectedGameNewsWorker.swift
//  GameNews
//
//  Created by Admin on 07.06.2021.
//

import Foundation

class SelectedGameNewsWorker {

    func fetchGameNews(appId: String, completion: @escaping ((GameNewsAppNewsModel) -> Void)) {
        let url = "https://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=\(appId)"
        NetworkManager.shared.get(url: url) { (result: Result<GameNewsAppNewsModel, Error>) in
            switch result {
            case .success(let gameNews):
                completion(gameNews)
            case .failure(let error):
                print(error)
            }
        }
    }

}
