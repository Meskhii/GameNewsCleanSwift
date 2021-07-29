//
//  Firebasemanager.swift
//  GameNews
//
//  Created by Admin on 26.07.2021.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseStorageSwift

protocol FirebaseManagerProtocol {
    func login(email: String, password: String, completion: @escaping (Bool) -> Void)
    func createUser(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Bool) -> Void)
    func bookmarkNewsInFirebase(title: String, image: String, newsUrl: String)
    func deleteNewsForUserFromFirebase(title: String)
    func checkIfNewsBookmarked(titles: [String], completion: @escaping ([Bool]) -> Void)
    func fetchBookmarkedNews(completion: @escaping ([[String: Any]]) -> Void)
    func saveProfileImageForUser(profileImage: UIImage)
    func getUserProfileImage(completion: @escaping (String) -> Void)
    func getUserFullName(completion: @escaping (String) -> Void)
    func signOut(completion: @escaping (Bool) -> Void)
}

class FirebaseManager: FirebaseManagerProtocol {

    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (_, err) in
            if err != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }

    func signOut(completion: @escaping (Bool) -> Void) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            completion(true)
        } catch {
            completion(false)
        }
    }

    func createUser(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (_, signUpError) in
            if signUpError != nil {
                completion(false)
            } else {
                let database = Firestore.firestore()
                let uid = Auth.auth().currentUser?.uid

                database.collection("users").document(uid!).setData([ "first_name": firstName,
                                                                      "last_name": lastName ], merge: true)

                completion(true)
            }
        }
    }

    func bookmarkNewsInFirebase(title: String, image: String, newsUrl: String) {
        let database = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid

        database.collection("users").document(uid!).collection("bookmarks").document(title).setData(["news_title": title, "news_image": image, "news_url": newsUrl])
    }

    func deleteNewsForUserFromFirebase(title: String) {
        let database = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid

        database.collection("users").document(uid!).collection("bookmarks").document(title).delete()
    }

    func checkIfNewsBookmarked(titles: [String], completion: @escaping ([Bool]) -> Void) {
        let database = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid

        var results = [Bool]()

        for title in titles {
            DispatchQueue.global(qos: .background).sync {
                database.collection("users").document(uid!).collection("bookmarks").document(title).getDocument { document, error in
                        if error == nil {
                            if document != nil && document!.exists {
                                results.append(true)
                            } else {
                                results.append(false)
                            }
                        } else {
                            results.append(false)
                        }
                    if results.count == titles.count {
                        completion(results)
                    }
                }
            }
        }

    }

    func fetchBookmarkedNews(completion: @escaping ([[String: Any]]) -> Void) {
        let database = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var documentData = [[String: Any]]()

        database.collection("users").document(uid).collection("bookmarks").getDocuments { snapshot, error in

            if error == nil && snapshot != nil {

                for document in snapshot!.documents {
                    documentData.append(document.data())
                }
                completion(documentData)
            }

        }
    }

    func saveProfileImageForUser(profileImage: UIImage) {
        let database = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }

        guard let imageData = profileImage.jpegData(compressionQuality: 0.5) else {return}
        let storageRef = Storage.storage().reference(forURL: "gs://gamenews-fc5aa.appspot.com")
        let storageProfileRef = storageRef.child("profile").child(uid)

        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        storageProfileRef.putData(imageData, metadata: metaData) { (_, error) in
            if error != nil {return}
            storageProfileRef.downloadURL { (url, _) in
                if let metaImageUrl = url?.absoluteString {
                    database.collection("users").document(uid).setData(["profile_image": metaImageUrl], merge: true)
                }
            }
        }
    }

    func getUserProfileImage(completion: @escaping (String) -> Void) {
        let firestore = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }

        var imageUrl = String()
        firestore.collection("users").document(uid).getDocument { snapshot, error in
            if error == nil && snapshot != nil {
                imageUrl = snapshot!["profile_image"] as? String ?? ""
                completion(imageUrl)
            }
        }
    }

    func getUserFullName(completion: @escaping (String) -> Void) {
        let firestore = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }

        var fullName = String()
        firestore.collection("users").document(uid).getDocument { snapshot, error in
            if error == nil && snapshot != nil {
                fullName = snapshot!["first_name"] as? String ?? ""
                fullName += " "
                fullName += snapshot!["last_name"] as? String ?? ""
                completion(fullName)
            }
        }
    }

}
