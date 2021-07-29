//
//  NewsCell.swift
//  GameNews
//
//  Created by Admin on 31.05.2021.
//

import UIKit
import Kingfisher

class IgnNewsCell: AppTableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var webPageImageView: UIImageView!
    @IBOutlet weak var webPageNameLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!

    // MARK: - Variables
    private var newsTitle: String?
    private var newsImage: String?
    private var newsHref: String?
    private var isBookmarked: Bool!

    // MARK: - Cell Layer Design
    private func setupNewsView() {
        newsView.layer.cornerRadius = 15
        newsImageView.layer.cornerRadius = 15
    }

    // MARK: - Cell Configuration
    override var dataProvider: AppCellDataProvider? {
        didSet {
            super.dataProvider = dataProvider

            guard let dataProvider = dataProvider as? NewsCellDataProvider else { fatalError() }

            setupNewsView()

            newsTitle = dataProvider.title
            newsImage = dataProvider.imgURL
            newsHref = dataProvider.hrefURL
            isBookmarked = dataProvider.isBookmarked ?? false

            newsTitleLabel.text = newsTitle
            newsDateLabel.text = dataProvider.postTime

            webPageImageView.image = UIImage(named: dataProvider.webPageLogo!)
            webPageNameLabel.text = dataProvider.webPageName

            let url = URL(string: newsImage ?? "")
            newsImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "ImagePlaceHolder"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.7)),
                    .cacheOriginalImage
                ])

            let imageName = isBookmarked ? "ic_bookmark_filled" : "ic_bookmark_empty"
            bookmarkButton.setImage(UIImage(named: imageName), for: .normal)
        }
    }

    override class var identifierCell: Identifierable {
        return AppTableViewCellIdentifier.ignNews
    }

    // MARK: - IBActions
    @IBAction func shareNews(_ sender: Any) {

        let defaultImage = "https://www.gamespot.com/a/uploads/screen_kubrick/123/1239113/3320903-thumb.jpg"
        guard let image = newsImageView.image, let url = URL(string: newsHref ?? defaultImage) else {return}

        delegate?.presentShareSheet(using: image, url: url)

    }

    @IBAction func bookmarkNews(_ sender: UIButton) {

        let imageName = isBookmarked ? "ic_bookmark_empty" : "ic_bookmark_filled"

        sender.setImage(UIImage(named: imageName), for: .normal)

        if isBookmarked {
            delegate?.removeBookmarkedNews(with: newsTitle ?? "")
        } else {
            delegate?.bookmarkNews(with: newsTitle ?? "",
                                   imageUrl: newsImage ?? "",
                                   newsUrl: newsHref ?? "")
        }

        isBookmarked.toggle()
    }

}
