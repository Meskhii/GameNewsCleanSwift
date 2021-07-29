//
//  ConfigureNewsViewController.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import UIKit

protocol ConfigureCheckedNewsLogic: AnyObject {
    func configureDataAfterUserInteraction(checkedLogo: String, checked: Bool)
}

protocol ConfigureNewsDisplayLogic: AnyObject {
    func displayWebPageOptions(data: [WebPagesModel])
}

class ConfigureNewsViewController: UIViewController {

    // MARK: - Variables
    var interactor: ConfigureNewsBusinessLogic?
    weak var delegate: NewsDelegate?
    var webPageOptions = [WebPagesModel]()

    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Setup Scene
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
        let presenter = ConfigureNewsPresenter()
        let interactor = ConfigureNewsInteractor()
        interactor.presenter = presenter
        presenter.configureNewsViewController = viewController
        viewController.interactor = interactor
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if webPageOptions.isEmpty {
            interactor?.fetchWebPageOptions()
        }

        setupCollectionView()
    }

    // MARK: - Setuper
    private func setupCollectionView() {
        collectionView.registerNib(class: ConfigureNewsCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // MARK: - Page Updater
    private func updateWebPages(webPage: String, checked: Bool) {
        for index in webPageOptions.indices {
            if webPageOptions[index].webPageLogo.contains(webPage) {
                webPageOptions[index].isWebPageChecked = checked
            }
        }
    }
}

// MARK: - Display Logic
extension ConfigureNewsViewController: ConfigureNewsDisplayLogic {
    func displayWebPageOptions(data: [WebPagesModel]) {
        webPageOptions = data
        collectionView.reloadData()
    }
}

// MARK: - Checked News Logic
extension ConfigureNewsViewController: ConfigureCheckedNewsLogic {
    func configureDataAfterUserInteraction(checkedLogo: String, checked: Bool) {
        updateWebPages(webPage: checkedLogo, checked: checked)
        delegate?.getUpdatedWebPages(webPages: webPageOptions)
        delegate?.updateWebSitesImages(checkedLogo: checkedLogo, checked: checked)
    }
}

// MARK: - UICollection View Data Source & Delegate
extension ConfigureNewsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return webPageOptions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.deque(ConfigureNewsCell.self, for: indexPath)
        cell.configure(with: webPageOptions[indexPath.row])
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollection View Delegate Flow Layout
extension ConfigureNewsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout  // swiftlint:disable:this force_cast

            let numberofItem: CGFloat = 2

            let collectionViewWidth = self.collectionView.bounds.width

            let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing

            let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left

            let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)

            return CGSize(width: width - 10, height: width - 60)
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}
