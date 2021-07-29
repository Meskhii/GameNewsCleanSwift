//
//  VideosInteractor.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import Foundation

protocol VideosBusinessLogic {
    func fetchVideosList()
}

class VideosInteractor {
    var presenter: VideosPresentationLogic?
    var worker: VideosWorker?
}

extension VideosInteractor: VideosBusinessLogic {

    func fetchVideosList() {
        var fetchedVideosTitles = [String]()
        var fetchedVideosImgUrls = [String]()
        var fetchedVideosIds = [String]()
        var videoCellModel = [VideoCellModel]()
        worker = VideosWorker()

        worker?.fetchVideosList { [unowned self] videosList in
            fetchedVideosTitles = videosList.items.map {($0?.snippet?.title ?? "")}
            fetchedVideosImgUrls = videosList.items.map {($0?.snippet?.thumbnails?.imgUrl?.url ?? "")}
            fetchedVideosIds = videosList.items.map {$0?.snippet?.resourceId?.videoId ?? ""}

            DispatchQueue.main.async {
                for index in 0..<fetchedVideosTitles.count {
                    videoCellModel.append(VideoCellModel(
                                            fetchedVideosTitle: fetchedVideosTitles[index],
                                            fetchedVideosImgUrl: fetchedVideosImgUrls[index],
                                            fetchedVideosId: fetchedVideosIds[index]))
                }

                self.presenter?.presentVideos(data: videoCellModel)
            }
        }
    }

}
