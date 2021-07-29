//
//  SignUpWorker.swift
//  GameNews
//
//  Created by Admin on 16.05.2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class SignUpWorker {

    let firebaseManager: FirebaseManagerProtocol!

    init() {
        firebaseManager = FirebaseManager()
    }

    func signUpUser(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        firebaseManager.createUser(firstName: firstName, lastName: lastName, email: email, password: password, completion: completion)
    }

}
