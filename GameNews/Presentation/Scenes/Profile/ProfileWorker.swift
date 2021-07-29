//
//  ProfileWorker.swift
//  GameNews
//
//  Created by user200006 on 6/13/21.
//

import UIKit
import Firebase

class ProfileWorker {

    let firebaseManager: FirebaseManagerProtocol!

    init() {
        firebaseManager = FirebaseManager()
    }

    func signOut(completion: @escaping (Bool) -> Void) {
        firebaseManager.signOut(completion: completion)
    }

    func saveProfileImageForUser(profileImage: UIImage) {
        firebaseManager.saveProfileImageForUser(profileImage: profileImage)
    }

    func getUserProfileImage(completion: @escaping (String) -> Void) {
        firebaseManager.getUserProfileImage(completion: completion)
    }

    func getUserFullName(completion: @escaping (String) -> Void) {
        firebaseManager.getUserFullName(completion: completion)
    }

}
