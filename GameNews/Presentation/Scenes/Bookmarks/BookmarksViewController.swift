//
//  BookmarksViewController.swift
//  GameNews
//
//  Created by user200006 on 6/14/21.
//

import UIKit

protocol BookmarksDelegate: AnyObject {
    func removeBookmarkedNews(using title: String)
    func readFullArticleUsing(url: String)
}

protocol BookmarksDisplayLogic: AnyObject {
    func displayBookmarks(data: [BookmarksModel])
}

class BookmarksViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Variables
    var interactor: BookmarksBusinessLogic?
    private(set) var router: BookmarksRoutingLogic?
    var bookmarkedNews = [BookmarksModel]()

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
        let presenter = BookmarksPresenter()
        let interactor = BookmarksInteractor()
        let router = BookmarksRouter()
        interactor.presenter = presenter
        presenter.bookmarksViewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        interactor?.fetchBookmarkedNews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        interactor?.fetchBookmarkedNews()

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    // MARK: - Table View Configuration
    private func configureTableView() {
        tableView.registerNib(class: BookmarkCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }

}

// MARK: - Display Logic
extension BookmarksViewController: BookmarksDisplayLogic {
    func displayBookmarks(data: [BookmarksModel]) {
        bookmarkedNews = data
        if tableView != nil {
            tableView.reloadData()
        }
    }
}

// MARK: - Bookmarks Delegate
extension BookmarksViewController: BookmarksDelegate {
    func removeBookmarkedNews(using title: String) {
        interactor?.deleteNewsForUserFromFirebase(title: title)
        interactor?.fetchBookmarkedNews()
        tableView.reloadData()
    }

    func readFullArticleUsing(url: String) {
        router?.openSelectedNewsInWebView(articleURL: url)
    }
}

// MARK: - UITableView Data Source
extension BookmarksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkedNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: BookmarkCell.self, for: indexPath)
        if !bookmarkedNews.isEmpty {
            cell.configure(with: bookmarkedNews[indexPath.row])
        }
        cell.bookmarksDelegate = self
        return cell
    }

}

// MARK: - UITableView Delegate
extension BookmarksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
