//
//  SelectedGameNewsViewController.swift
//  GameNews
//
//  Created by Admin on 07.06.2021.
//

import UIKit

protocol SelectedGameNewsCellDelegate: AnyObject {
    func readFullArticleTappedFor(_ articleURL: String)
}

protocol SelectedGameNewsDisplayLogic: AnyObject {
    func display(data: [GameNewsModel])
}

class SelectedGameNewsViewController: UIViewController {

    // MARK: - Variables
    var interactor: SelectedGameNewsBusinessLogic?
    var selectedGameNews = [GameNewsModel]()
    private(set) var router: SelectedGameNewsRoutingLogic?
    var appId: String?

    // MARK: - IBOutlet
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
        let presenter = SelectedGameNewsPresenter()
        let interactor = SelectedGameNewsInteractor()
        let router = SelectedGameNewsRouter()
        interactor.presenter = presenter
        presenter.selectedGameNewsViewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false

        configureTableView()
        interactor?.fetchSelectedGameNews(appId: appId ?? "")
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
        self.tableView.registerNib(class: SelectedGameNewsCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - Display Logic
extension SelectedGameNewsViewController: SelectedGameNewsDisplayLogic {
    func display(data: [GameNewsModel]) {
          self.selectedGameNews = data
          tableView.reloadData()
    }
}

// MARK: - UITableView Data Source & Delegate
extension SelectedGameNewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedGameNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: SelectedGameNewsCell.self, for: indexPath)
        cell.configure(with: selectedGameNews[indexPath.row])
        cell.delegate = self
        return cell
    }

}
// MARK: - News Cell Delegate
extension SelectedGameNewsViewController: SelectedGameNewsCellDelegate {
    func readFullArticleTappedFor(_ articleURL: String) {
        router?.openSelectedGameNewsInSafariView(using: articleURL)
    }
}
