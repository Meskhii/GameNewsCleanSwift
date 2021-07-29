//
//  ProfileRouter.swift
//  GameNews
//
//  Created by user200006 on 6/13/21.
//

import UIKit
import MessageUI

protocol ProfileRoutingLogic {
    func openMailSender(with subject: String)
    func moveUserToWelcomePage()
    func presentImagePicker()
}

class ProfileRouter: NSObject {
    weak var viewController: UIViewController?
}

extension ProfileRouter: ProfileRoutingLogic {

    func moveUserToWelcomePage() {
        let storyboard = UIStoryboard(name: VCIds.welcomeVC, bundle: nil)
        let welcomeVC = storyboard.instantiateViewController(withIdentifier: VCIds.welcomeNavigationController)
        welcomeVC.modalPresentationStyle = .fullScreen
        viewController?.present(welcomeVC, animated: true)
    }

    func presentImagePicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = viewController as? ProfileViewController
        viewController?.present(picker, animated: true)
    }

    func openMailSender(with subject: String) {
        guard MFMailComposeViewController.canSendMail() else {
            print("error opening MailComposer")
            return
        }

        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["request@mail.com"])
        composer.setSubject(subject)

        viewController?.present(composer, animated: true)
    }
}

// MARK: - Mail Compose Delegate
extension ProfileRouter: MFMailComposeViewControllerDelegate {

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

        if error != nil {
            controller.dismiss(animated: true)
            return
        }

        switch result {
        case .cancelled:
            print("Cancelled")
        case .saved:
            print("Saved")
        case .sent:
            print("Sent")
        case .failed:
            print("Failed")
        @unknown default:
            print("Unknown Error")
        }

        controller.dismiss(animated: true)

    }

}
