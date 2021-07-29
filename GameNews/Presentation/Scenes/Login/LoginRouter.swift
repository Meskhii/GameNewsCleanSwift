//
//  LoginRouter.swift
//  GameNews
//
//  Created by Admin on 15.05.2021.
//

import Foundation
import UIKit

protocol LoginRoutingLogic {
    func navigateToNews(vcId: String)
}

class LoginRouter {
    // MARK: - Variables
    weak var viewController: UIViewController?
}

// MARK: - Routing Logic
extension LoginRouter: LoginRoutingLogic {
    func navigateToNews(vcId: String) {
        let storyboard = UIStoryboard(name: VCIds.tabBarController, bundle: nil)
        guard let tabBarVC = storyboard.instantiateViewController(identifier: vcId) as? TabBarController else {return}

        tabBarVC.modalPresentationStyle = .fullScreen

        viewController?.present(tabBarVC, animated: true)
    }

}
