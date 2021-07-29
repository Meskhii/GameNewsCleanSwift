//
//  MainRouter.swift
//  GameNews
//
//  Created by Admin on 15.05.2021.
//

import Foundation
import UIKit

protocol WelcomeRoutingLogic {
    func navigateToSignUp(vcId: String)
    func navigateToLogin(vcId: String)
    func navigateToNews(vcId: String)
}

class WelcomeRouter {
    // MARK: - Variables
    weak var viewController: UIViewController?
}

// MARK: - Routing Logic
extension WelcomeRouter: WelcomeRoutingLogic {

    func navigateToSignUp(vcId: String) {
        let storyboard = UIStoryboard(name: VCIds.signUpVC, bundle: nil)
        guard let signUpVC = storyboard.instantiateViewController(identifier: vcId) as? SignUpViewController else {return}

        viewController?.navigationController?.pushViewController(signUpVC, animated: true)
    }

    func navigateToLogin(vcId: String) {
        let storyboard = UIStoryboard(name: VCIds.loginVC, bundle: nil)
        guard let loginVC = storyboard.instantiateViewController(identifier: vcId) as? LoginViewController else {return}

        viewController?.navigationController?.pushViewController(loginVC, animated: true)
    }

    func navigateToNews(vcId: String) {
        let storyboard = UIStoryboard(name: VCIds.tabBarController, bundle: nil)
        guard let tabBarVC = storyboard.instantiateViewController(identifier: vcId) as? TabBarController else {return}

        tabBarVC.modalPresentationStyle = .fullScreen

        viewController?.present(tabBarVC, animated: true)
    }

}
