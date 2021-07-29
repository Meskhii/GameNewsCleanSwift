//
//  BookmarksInteractor.swift
//  GameNews
//
//  Created by user200006 on 6/14/21.
//

import Foundation

protocol BookmarksBusinessLogic {
    func fetchBookmarkedNews()
    func deleteNewsForUserFromFirebase(title: String)
}

class BookmarksInteractor {
    var presenter: BookmarksPresentationLogic?
    let bookmarksWorker = BookmarksWorker()
}

extension BookmarksInteractor: BookmarksBusinessLogic {
    func fetchBookmarkedNews() {

        var bookmarksDict = [[String: Any]]()

        bookmarksWorker.fetchBookmarkedNews { [unowned self] bookmarkedData in
            bookmarksDict = bookmarkedData
            DispatchQueue.main.async {
                self.presenter?.present(bookmarks: bookmarksDict)
            }
        }
    }

    func deleteNewsForUserFromFirebase(title: String) {
        bookmarksWorker.deleteNewsForUserFromFirebase(title: title)
    }
}
