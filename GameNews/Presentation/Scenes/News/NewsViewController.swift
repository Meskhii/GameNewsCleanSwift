//
//  HomeViewController.swift
//  GameNews
//
//  Created by Admin on 08.05.2021.
//

import UIKit

protocol NewsDelegate: AnyObject {
    func updateWebSitesImages(checkedLogo: String, checked: Bool)
    func getUpdatedWebPages(webPages: [WebPagesModel])
    func presentShareSheet(using image: UIImage, url: URL)
    func bookmarkNews(with title: String, imageUrl: String, newsUrl: String)
    func removeBookmarkedNews(with title: String)
}

protocol NewsDisplayLogic: AnyObject {
    func display(data: [NewsCellModel])
}

class NewsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Variables
    fileprivate var dataProviders = [AppCellDataProvider]()
    private var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    var interactor: NewsBusinessLogic?
    var router: NewsRoutingLogic?
    var worker: NewsWorker?

    private var webSitesImages = ["ic_add", "ign_logo", "gameinformer_logo", "eurogamer_logo", "gamespot_logo", "pcgamer_logo"]

    private var webPages = [WebPagesModel]()
    private var dataAppendCount = 0
    var tempAllNews = [AppCellDataProvider]()

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
        let presenter = NewsPresenter()
        let interactor = NewsInteractor()
        let router = NewsRouter()
        worker = NewsWorker()
        interactor.presenter = presenter
        presenter.newsViewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.fetchNews(webPageNames: webSitesImages)

        navigationController?.navigationBar.isHidden = true

        configureCollectionView()
        configureTableView()
        setupActivityIndicator()
        activityIndicator.startAnimating()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    // MARK: - Collection View Configuration
    private func configureCollectionView() {
        collectionView.registerNib(class: WebPagesCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(named: "ViewBackground")
        collectionView.showsHorizontalScrollIndicator = false

        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
               flowLayout.scrollDirection = .horizontal
        }
    }

    // MARK: - Table View Configuration
    private func configureTableView() {
        tableView.register(types: [
            GamespotNewsCell.self,
            IgnNewsCell.self,
            GameInformerNewsCell.self
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }

    // MARK: - Helper Methods

    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = UIColor.white
        activityIndicator.center = view.center
        activityIndicator.isHidden = true
        self.view.addSubview(self.activityIndicator)
    }

}
// MARK: - Display logic
extension NewsViewController: NewsDisplayLogic {
    func display(data: [NewsCellModel]) {
        data.forEach { [unowned self] newsModel in
            self.dataProviders.append(News(with: newsModel))
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }

        dataProviders.shuffle()
        if dataAppendCount <= 3 {
            tempAllNews.append(contentsOf: dataProviders)
            dataAppendCount += 1
        }

        if tableView != nil {
            tableView.reloadData()
        }

    }
}

// MARK: - News Delegate
extension NewsViewController: NewsDelegate {

    func presentShareSheet(using image: UIImage, url: URL) {
        router?.presentShareSheetForNews(image: image, url: url)
    }

    func getUpdatedWebPages(webPages: [WebPagesModel]) {
        self.webPages = webPages
    }

    func updateWebSitesImages(checkedLogo: String, checked: Bool) {
        if checked {
            if !webSitesImages.contains(checkedLogo) {
                webSitesImages.append(checkedLogo)
            }
        } else {
            while let index = webSitesImages.firstIndex(of: checkedLogo) {
                webSitesImages.remove(at: index)
            }
        }
        dataProviders.removeAll()
        interactor?.fetchNews(webPageNames: webSitesImages)
        tableView.reloadData()
        collectionView.reloadData()
    }

    func bookmarkNews(with title: String, imageUrl: String, newsUrl: String) {
        worker?.bookmarkNewsInFirebase(title: title, image: imageUrl, newsUrl: newsUrl)
        guard let newsList = dataProviders as? [NewsCellDataProvider] else { fatalError() }
        for news in newsList where news.title == title {
            news.isBookmarked = true
        }
    }

    func removeBookmarkedNews(with title: String) {
        worker?.deleteNewsForUserFromFirebase(title: title)
        guard let newsList = dataProviders as? [NewsCellDataProvider] else { fatalError() }

        for news in newsList where news.title == title {
            news.isBookmarked = false
        }
    }

}

// MARK: - UICollectionView Data Source
extension NewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return webSitesImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(WebPagesCell.self, for: indexPath)
        cell.configure(with: webSitesImages[indexPath.row])
        return cell
    }

}

// MARK: - UICollection View Delegate
extension NewsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            router?.openConfigureNewsViewController(with: webPages)
            collectionView.deselectItem(at: indexPath, animated: false)
        }
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let item = collectionView.cellForItem(at: indexPath)

        if item?.isSelected ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
            dataProviders = tempAllNews
            tableView.reloadData()
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            dataProviders.removeAll()
            interactor?.fetchNews(webPageNames: [webSitesImages[indexPath.row]])
            return true
        }

        return false
    }
}

// MARK: - UICollectionView Flow Layout
extension NewsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }

}

// MARK: - UITableView Data Source
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProviders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !dataProviders.isEmpty {
            let dataProvider = dataProviders[indexPath.row]
            let cell = tableView.dequeueReusable(dataProvider: dataProvider, for: indexPath)
            cell.dataProvider = dataProvider
            cell.delegate = self
            return cell
        }
        return .init()
    }
}

// MARK: - UITableView Delegate
extension NewsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let news = dataProviders[indexPath.row] as? NewsCellDataProvider else { fatalError() }
        router?.openSelectedNewsInWebView(defaultURL: news.webPageURL ?? "", articleURL: news.hrefURL ?? "")
    }
}
