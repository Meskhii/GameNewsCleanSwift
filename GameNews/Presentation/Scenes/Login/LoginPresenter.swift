//
//  LoginPresenter.swift
//  GameNews
//
//  Created by Admin on 15.05.2021.
//

import Foundation

protocol LoginPresentationLogic: AnyObject {
    func presentUser(response: Login.Response)
}

class LoginPresenter {
    // MARK: - Variables
    weak var viewController: LoginDisplayLogic?
}

// MARK: - Presentation logic
extension LoginPresenter: LoginPresentationLogic {
    func presentUser(response: Login.Response) {
        let viewModel = Login.ViewModel(success: response.success)
        viewController?.displayLoginResult(viewModel: viewModel)
    }
}
