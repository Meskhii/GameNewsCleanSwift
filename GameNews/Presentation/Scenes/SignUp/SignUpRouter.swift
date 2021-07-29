//
//  SignUpRouter.swift
//  GameNews
//
//  Created by Admin on 15.05.2021.
//

import Foundation
import UIKit

protocol SignUpRoutingLogic {
    func navigateToNews(vcId: String)
}

class SignUpRouter {
    // MARK: - Variables
    weak var viewController: UIViewController?
}

// MARK: - Routing logic
extension SignUpRouter: SignUpRoutingLogic {

    func navigateToNews(vcId: String) {
        let storyboard = UIStoryboard(name: VCIds.tabBarController, bundle: nil)
        guard let tabBarVC = storyboard.instantiateViewController(identifier: vcId) as? TabBarController else {return}

        viewController?.navigationController?.pushViewController(tabBarVC, animated: true)
    }

}
