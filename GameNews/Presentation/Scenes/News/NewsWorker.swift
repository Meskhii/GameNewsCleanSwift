//
//  NewsWorker.swift
//  GameNews
//
//  Created by Admin on 30.05.2021.
//

import Foundation
import SwiftSoup
import Firebase

class NewsWorker {

    let firebaseManager: FirebaseManagerProtocol!

    init() {
        firebaseManager = FirebaseManager()
    }

    func bookmarkNewsInFirebase(title: String, image: String, newsUrl: String) {
        firebaseManager.bookmarkNewsInFirebase(title: title, image: image, newsUrl: newsUrl)
    }

    func deleteNewsForUserFromFirebase(title: String) {
        firebaseManager.deleteNewsForUserFromFirebase(title: title)
    }

    func checkIfNewsBookmarked(titles: [String], completion: @escaping ([Bool]) -> Void) {
        firebaseManager.checkIfNewsBookmarked(titles: titles, completion: completion)
    }

    // MARK: - IGN Worker
    func getIgnNews<T: Codable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {

        guard let url = URL(string: url) else {return}

        do {
            let htmlString = try String(contentsOf: url, encoding: .utf8)
            let htmlContent = htmlString

            do {
                let doc = try SwiftSoup.parse(htmlContent)
                fetchLogicForIgn(doc: doc) { result in
                    completion(.success(result as! T))  // swiftlint:disable:this force_cast
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }

    // MARK: - Game Informer Worker
    func getGameInformerNews<T: Codable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {

        guard let url = URL(string: url) else {return}

        do {
            let htmlString = try String(contentsOf: url, encoding: .utf8)
            let htmlContent = htmlString

            do {
                let doc = try SwiftSoup.parse(htmlContent)
                fetchLogicForGameInformer(doc: doc) { result in
                    completion(.success(result as! T))  // swiftlint:disable:this force_cast
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }

    // MARK: - Gamespot Worker
    func getGamespotNews<T: Codable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {

        guard let url = URL(string: url) else {return}

        do {
            let htmlString = try String(contentsOf: url, encoding: .utf8)
            let htmlContent = htmlString

            do {
                let doc = try SwiftSoup.parse(htmlContent)
                fetchLogicForGamespot(doc: doc) { result in
                    completion(.success(result as! T))  // swiftlint:disable:this force_cast
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
}
