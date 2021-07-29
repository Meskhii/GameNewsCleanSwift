//
//  VideosWorker.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import Foundation

class VideosWorker {

    func fetchVideosList(completion: @escaping ((ChannelVideosModel) -> Void)) {
        let channelId = "UUJx5KP-pCUmL9eZUv-mIcNw"
        let apiKey = "AIzaSyCML2mbvR0V-f6ZgjFA8Iw1cOCKvb3zHcw"
        let url = "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=\(channelId)&key=\(apiKey)&part=snippet&maxResults=50"

        NetworkManager.shared.get(url: url) { (result: Result<ChannelVideosModel, Error>) in
            switch result {
            case .success(let gameNews):
                completion(gameNews)
            case .failure(let error):
                print(error)
            }
        }
    }

}
