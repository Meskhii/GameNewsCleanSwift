//
//  SelectedGameNewsCell.swift
//  GameNews
//
//  Created by Admin on 07.06.2021.
//

import UIKit

class SelectedGameNewsCell: UITableViewCell {

    private var fullArticleHref: String?
    weak var delegate: SelectedGameNewsCellDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with data: GameNewsModel) {

        self.titleLabel.text = data.title

        let string = data.contents
        let str = string?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        self.contentLabel.text = str

        self.authorLabel.text = data.author
        self.fullArticleHref = data.url
    }

    @IBAction func readFullArticle(_ sender: Any) {
        delegate?.readFullArticleTappedFor(fullArticleHref ?? "")
    }

}
