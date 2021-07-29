//
//  VideosViewController.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import UIKit

protocol SelectedVideoDelegate: AnyObject {
    func getSelectedVideoToPlay(_ videoId: String)
}

protocol VideosDisplayLogic: AnyObject {
    func displayVideos(_ data: [VideoCellModel])
}

class VideosViewController: UIViewController {

    // MARK: - Variables
    var interactor: VideosBusinessLogic?
    private(set) var router: VideosRoutingLogic?
    var fetchedVideos = [VideoCellModel]()

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Scene Setup
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let viewController = self
        let presenter = VideosPresenter()
        let interactor = VideosInteractor()
        let router = VideosRouter()
        interactor.presenter = presenter
        presenter.videosViewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.fetchVideosList()

        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    // MARK: - Table View Configuration
    private func configureTableView() {
        tableView.registerNib(class: VideoCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - Display Logic
extension VideosViewController: VideosDisplayLogic {
    func displayVideos(_ data: [VideoCellModel]) {
        self.fetchedVideos = data
        if tableView != nil {
            tableView.reloadData()
        }
    }
}

// MARK: - Video Delegate
extension VideosViewController: SelectedVideoDelegate {
    func getSelectedVideoToPlay(_ videoId: String) {
        router?.navigateToPlayVideoForSelected(videoId: videoId)
    }
}

// MARK: - UITable View Data Source & Delegate
extension VideosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedVideos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: VideoCell.self, for: indexPath)
        cell.configure(with: fetchedVideos[indexPath.row])
        cell.delegate = self
        return cell
    }

}
