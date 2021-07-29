//
//  ProfileInteractor.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import UIKit

protocol ProfileBusinessLogic {
    func saveProfileImageForUser(profileImage: UIImage)
    func getUserProfileImage()
    func getUserFullName()
}

class ProfileInteractor {
    var presenter: ProfilePresentationLogic?
    let bookmarksWorker = ProfileWorker()
}

extension ProfileInteractor: ProfileBusinessLogic {

    func saveProfileImageForUser(profileImage: UIImage) {
        bookmarksWorker.saveProfileImageForUser(profileImage: profileImage)
    }

    func getUserFullName() {
        bookmarksWorker.getUserFullName { [weak self] fullName in
            self?.presenter?.setUserFullName(fullName: fullName)
        }
    }

    func getUserProfileImage() {
        bookmarksWorker.getUserProfileImage { [weak self] profileImage in
            self?.presenter?.setUserProfileImage(imageUrl: profileImage)
        }
    }

}
