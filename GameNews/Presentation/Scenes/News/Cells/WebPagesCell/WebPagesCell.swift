//
//  SitesCell.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import UIKit

class WebPagesCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var webSitesButton: UIButton!

    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Cell Configuration
    func configure(with image: String) {
        self.webSitesButton.setBackgroundImage(UIImage(named: image), for: .normal)
        self.webSitesButton.setTitle("", for: .normal)
    }

}
