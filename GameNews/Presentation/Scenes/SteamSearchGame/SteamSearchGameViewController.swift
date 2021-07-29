//
//  SteamNewsViewController.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import UIKit

protocol SteamSearchGameDisplayLogic: AnyObject {
    func displaySearchResult(with data: [SearchResultCellModel])
}

class SteamSearchGameViewController: UIViewController {

    // MARK: - Variables
    var interactor: SteamSearchGameBusinessLogic?
    private(set) var router: SteamSearchGameRoutingLogic?
    var searchResults = [SearchResultCellModel]()

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

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
        let presenter = SteamSearchGamePresenter()
        let interactor = SteamSearchGameInteractor()
        let router = SteamSearchGameRouter()
        interactor.presenter = presenter
        presenter.steamSearchGameViewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.fetchSearchedGames(by: "")

        self.searchBar.delegate = self

        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.navigationBar.isHidden = true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    // MARK: - Table View Configuration
    private func configureTableView() {
        tableView.registerNib(class: SearchResultCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}
// MARK: - Display Logic
extension SteamSearchGameViewController: SteamSearchGameDisplayLogic {
    func displaySearchResult(with data: [SearchResultCellModel]) {
        self.searchResults = data
        tableView.reloadData()
    }
}
// MARK: - UITableView Data Source
extension SteamSearchGameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: SearchResultCell.self, for: indexPath)
        cell.configure(searchResult: searchResults[indexPath.row])
        return cell
    }

}
// MARK: - UITableView Delegate
extension SteamSearchGameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.navigateToSelectedGameNews(with: searchResults[indexPath.row].appId ?? "")
    }
}
// MARK: - Search Bar Delegate
extension SteamSearchGameViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor?.fetchSearchedGames(by: searchText)
    }
}
