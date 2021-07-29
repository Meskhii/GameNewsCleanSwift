//
//  ProfileViewController.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import UIKit
import Kingfisher

protocol ProfileDisplayLogic: AnyObject {
    func displaySignOutError()
    func displayUserProfileImage(_ imageUrl: String)
    func displayUserFullName(_ fullName: String)
}

class ProfileViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!

    // MARK: - Variables
    private var interactor: ProfileBusinessLogic?
    private(set) var router: ProfileRoutingLogic?
    private var worker: ProfileWorker?

    // MARK: Scene Setup
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let viewController = self
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        let worker = ProfileWorker()
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        viewController.worker = worker
        router.viewController = viewController
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.getUserFullName()
        interactor?.getUserProfileImage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    // MARK: - IBActions
    @IBAction func updateProfilePicture(_ sender: Any) {
        router?.presentImagePicker()
    }

    @IBAction func requestNewsWebPage(_ sender: Any) {
        router?.openMailSender(with: "Request News Page")
    }

    @IBAction func requestFeature(_ sender: Any) {
        router?.openMailSender(with: "Request Feature")
    }

    @IBAction func logoutUser(_ sender: Any) {
        worker?.signOut { [unowned self] result in
            if result {
                self.router?.moveUserToWelcomePage()
                UserDefaults.standard.set(false, forKey: "isUserSignedIn")
            } else {
                self.displaySignOutError()
            }
        }
    }

}
// MARK: - Display Logic
extension ProfileViewController: ProfileDisplayLogic {
    func displaySignOutError() {
        print("SignOut Error")
    }

    func displayUserProfileImage(_ imageUrl: String) {
        if !imageUrl.isEmpty {
            userProfileImageView.kf.setImage(with: URL(string: imageUrl))
        }
    }

    func displayUserFullName(_ fullName: String) {
        userFullNameLabel.text = fullName
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            userProfileImageView.image = imageSelected
        }

        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userProfileImageView.image = imageOriginal
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
