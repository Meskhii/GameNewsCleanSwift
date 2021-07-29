//
//  VideosPresenter.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import Foundation

protocol VideosPresentationLogic {
    func presentVideos(data: [VideoCellModel])
}

class VideosPresenter {
    weak var videosViewController: VideosDisplayLogic?
}

extension VideosPresenter: VideosPresentationLogic {
    func presentVideos(data: [VideoCellModel]) {
        videosViewController?.displayVideos(data)
    }
}
