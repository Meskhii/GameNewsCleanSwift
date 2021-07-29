//
//  BookmarksPresenter.swift
//  GameNews
//
//  Created by user200006 on 6/14/21.
//

import Foundation

protocol BookmarksPresentationLogic {
    func present(bookmarks: [[String: Any]])
}

class BookmarksPresenter {
    weak var bookmarksViewController: BookmarksDisplayLogic?
}

extension BookmarksPresenter: BookmarksPresentationLogic {
    func present(bookmarks: [[String: Any]]) {
        var bookmarksModel = [BookmarksModel]()

        for bookmark in bookmarks {
            bookmarksModel.append(BookmarksModel(newsImage: bookmark["news_image"] as! String, // swiftlint:disable:this force_cast
                                                 newsTitle: bookmark["news_title"] as! String, // swiftlint:disable:this force_cast
                                                 newsUrl: bookmark["news_url"] as! String)) // swiftlint:disable:this force_cast
        }
        bookmarksViewController?.displayBookmarks(data: bookmarksModel)
    }
}
