//
//  SignUpPresenter.swift
//  GameNews
//
//  Created by Admin on 15.05.2021.
//

import Foundation

protocol SignUpPresentationLogic: AnyObject {
    func presentSignUp(response: SignUp.Response)
}

class SignUpPresenter {
    // MARK: - Variables
    weak var viewController: SignUpDisplayLogic?
}

// MARK: - Presentation logic
extension SignUpPresenter: SignUpPresentationLogic {
    func presentSignUp(response: SignUp.Response) {
        let viewModel = SignUp.ViewModel(success: response.success)
        viewController?.displaySignUpResult(viewModel: viewModel)
    }
}
