//
//  ProfilePresenter.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import UIKit

protocol ProfilePresentationLogic {
    func showSignOutError()
    func setUserProfileImage(imageUrl: String)
    func setUserFullName(fullName: String)
}

class ProfilePresenter {
    weak var viewController: ProfileDisplayLogic?
}

extension ProfilePresenter: ProfilePresentationLogic {

    func setUserProfileImage(imageUrl: String) {
        viewController?.displayUserProfileImage(imageUrl)
    }

    func setUserFullName(fullName: String) {
        viewController?.displayUserFullName(fullName)
    }

    func showSignOutError() {
        viewController?.displaySignOutError()
    }
}
