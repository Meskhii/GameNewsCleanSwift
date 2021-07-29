//
//  PlayVideoViewController.swift
//  GameNews
//
//  Created by Admin on 10.06.2021.
//

import UIKit
import YouTubeiOSPlayerHelper

protocol PlayVideoDisplayLogic: AnyObject {
    func playVideo(with videoId: String)
}

class PlayVideoViewController: UIViewController {

    var videoId: String?

    @IBOutlet var playerView: YTPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        playerView.delegate = self
        playVideo(with: videoId ?? "")
    }

    @IBAction func closeCurrentVideo(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PlayVideoViewController: PlayVideoDisplayLogic {
    func playVideo(with videoId: String) {
        playerView.load(withVideoId: videoId, playerVars: ["playsinline": 1])
    }
}

extension PlayVideoViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
