//
//  SignUpViewController.swift
//  GameNews
//
//  Created by Admin on 08.05.2021.
//

import UIKit

protocol SignUpDisplayLogic: AnyObject {
    func displaySignUpResult(viewModel: SignUp.ViewModel)
}

class SignUpViewController: UIViewController {

    // MARK: - Variables
    var router: SignUpRoutingLogic?
    private var interactor: SignUpBusinessLogic?

    private var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    private var effectView: UIVisualEffectView!

    // MARK: - IBOutlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var activityIndicatorView: UIView!

    // MARK: - Scene Setup
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
        let presenter = SignUpPresenter()
        let interactor = SignUpInteractor()
        let router = SignUpRouter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()

        setupActivityIndicator()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Sign Up User
    @IBAction func signUpTapped(_ sender: Any) {
        animateInActivityIndicator()
        self.navigationController?.navigationBar.isHidden = true
        self.view.isUserInteractionEnabled = false
        signUp()
    }

    private func signUp() {
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let request = SignUp.Request(firstName: firstName, lastName: lastName, email: email, password: password)
        interactor?.signUpUser(request: request)
    }

    // MARK: - Helper Methods
    private func setUpElements() {
        errorLabel.alpha = 0

        ButtonsDesign.styleFilledButton(signUpButton)
    }

    private func showError(message: String) {
        errorLabel.alpha = 1
        errorLabel.text = message
    }

    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = view.center
        activityIndicator.isHidden = true
    }

    private func makeEffectView() {
        let effect: UIBlurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        effectView = UIVisualEffectView(effect: effect)
        effectView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.view.addSubview(effectView)
    }

    private func animateInActivityIndicator() {
        makeEffectView()
        self.view.addSubview(activityIndicatorView)
        self.view.addSubview(activityIndicator)
        activityIndicatorView.center = self.view.center
        activityIndicatorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        activityIndicatorView.alpha = 0
        activityIndicator.alpha = 0
        self.navigationController?.navigationBar.isHidden = true

        UIView.animate(withDuration: 0.4) {
            self.activityIndicatorView.alpha = 1
            self.activityIndicator.alpha = 1
            self.activityIndicatorView.transform = CGAffineTransform.identity
            self.activityIndicator.startAnimating()
        }
    }

    private func animateOutActivityIndicator() {

        UIView.animate(withDuration: 0.3, animations: {

            self.activityIndicatorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.activityIndicatorView.alpha = 0
            self.navigationController?.navigationBar.isHidden = false

        }) { (_: Bool) in
            self.activityIndicatorView.removeFromSuperview()
            self.activityIndicator.stopAnimating()
            if self.effectView != nil {
                self.effectView.removeFromSuperview()
            }
        }
    }

}

// MARK: - Display logic
extension SignUpViewController: SignUpDisplayLogic {
    func displaySignUpResult(viewModel: SignUp.ViewModel) {
        if viewModel.success {
            router?.navigateToNews(vcId: VCIds.tabBarController)
            animateOutActivityIndicator()
            self.view.isUserInteractionEnabled = true
            UserDefaults.standard.set(true, forKey: "isUserSignedIn")
        } else {
            showError(message: "Sign up error. Please try again.")
            animateOutActivityIndicator()
            self.view.isUserInteractionEnabled = true
            self.navigationController?.navigationBar.isHidden = false
        }
    }
}
