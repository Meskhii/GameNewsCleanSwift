//
//  LoginViewController.swift
//  GameNews
//
//  Created by Admin on 08.05.2021.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    func displayLoginResult(viewModel: Login.ViewModel)
}

class LoginViewController: UIViewController {

    // MARK: - Variables
    var router: LoginRoutingLogic?
    private var interactor: LoginBusinessLogic?
    private var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    private var effectView: UIVisualEffectView!

    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    @IBOutlet var activityIndicatorView: UIView!

    // MARK: - Setup Scene
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
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()

        setUpElements()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Login User
    @IBAction func loginClicked(_ sender: UIButton) {
        animateInActivityIndicator()
        self.view.isUserInteractionEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        login()
    }

    private func login() {
        let email = emailTextField.text
        let password = passwordTextField.text
        let request = Login.Request(email: email, password: password)
        interactor?.fetchUser(request: request)
    }

    // MARK: - Helper methods
   private  func showError(message: String) {
        errorLabel.alpha = 1
        errorLabel.text = message
    }

    private func setUpElements() {
        errorLabel.alpha = 0
        ButtonsDesign.styleFilledButton(loginButton)
    }

    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = view.center
        activityIndicator.isHidden = true
        self.view.addSubview(self.activityIndicator)
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
extension LoginViewController: LoginDisplayLogic {
    func displayLoginResult(viewModel: Login.ViewModel) {
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
