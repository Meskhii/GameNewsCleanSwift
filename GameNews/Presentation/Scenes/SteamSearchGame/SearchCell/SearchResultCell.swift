//
//  SearchCell.swift
//  GameNews
//
//  Created by Admin on 07.06.2021.
//

import UIKit
import Kingfisher

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameReleaseDateLabel: UILabel!
    @IBOutlet weak var gamePriceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(searchResult: SearchResultCellModel) {

        let url = URL(string: searchResult.imgURL ?? "")
        gameImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "ImagePlaceHolder"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.7))
            ])

        gameNameLabel.text = searchResult.title
        gameReleaseDateLabel.text = searchResult.releaseDate
        gamePriceLabel.text = searchResult.gamePrice
    }

}
