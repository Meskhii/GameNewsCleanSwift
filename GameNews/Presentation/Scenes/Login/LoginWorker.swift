//
//  LoginWorker.swift
//  GameNews
//
//  Created by Admin on 17.05.2021.
//

import Foundation

import Firebase
import FirebaseFirestore
import FirebaseAuth

class LoginWorker {

    let firebaseManager: FirebaseManagerProtocol!

    init() {
        firebaseManager = FirebaseManager()
    }

    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        firebaseManager.login(email: email, password: password, completion: completion)
    }

}
