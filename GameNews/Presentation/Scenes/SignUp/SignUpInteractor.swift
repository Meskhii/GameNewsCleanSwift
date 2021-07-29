//
//  SignUpInteractor.swift
//  GameNews
//
//  Created by Admin on 15.05.2021.
//

import Foundation

protocol SignUpBusinessLogic {
    func signUpUser(request: SignUp.Request)
}

class SignUpInteractor {
    // MARK: - Variables
    var presenter: SignUpPresentationLogic?
}

// MARK: - Business logic
extension SignUpInteractor: SignUpBusinessLogic {
    func signUpUser(request: SignUp.Request) {
        let firstName = request.firstName
        let lastName = request.lastName
        let email = request.email
        let password = request.password
        let signUpWorker = SignUpWorker()
        signUpWorker.signUpUser(firstName: firstName!, lastName: lastName!, email: email!, password: password!) { result in
            let response = SignUp.Response(success: result)
            self.presenter?.presentSignUp(response: response)
        }
    }
}
