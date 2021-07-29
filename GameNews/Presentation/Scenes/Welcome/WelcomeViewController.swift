//
//  ViewController.swift
//  GameNews
//
//  Created by Admin on 08.05.2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    // MARK: - Variables
    var router: WelcomeRoutingLogic!

    // MARK: - IBOutlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    // MARK: - Scene Setup
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        let viewController = self
        let router = WelcomeRouter()
        viewController.router = router
        router.viewController = viewController
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.bool(forKey: "isUserSignedIn") {
            router.navigateToNews(vcId: VCIds.tabBarController)
        }

        setUpElements()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - IBAction Methods
    @IBAction func onSignUp(_ sender: Any) {
        router?.navigateToSignUp(vcId: "SignUpViewController")
    }

    @IBAction func onLogin(_ sender: Any) {
        router?.navigateToLogin(vcId: "LoginViewController")
    }

    // MARK: - Helper Methods
    func setUpElements() {
        ButtonsDesign.styleFilledButton(signUpButton)
        ButtonsDesign.styleHollowButton(loginButton)
    }

}
