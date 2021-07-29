//
//  BookmarksWorker.swift
//  GameNews
//
//  Created by user200006 on 6/14/21.
//

import UIKit
import Firebase

class BookmarksWorker {

    let firebaseManager: FirebaseManagerProtocol!

    init() {
        firebaseManager = FirebaseManager()
    }

    func fetchBookmarkedNews(completion: @escaping ([[String: Any]]) -> Void) {
        firebaseManager.fetchBookmarkedNews(completion: completion)
    }

    func deleteNewsForUserFromFirebase(title: String) {
        firebaseManager.deleteNewsForUserFromFirebase(title: title)
    }
}
