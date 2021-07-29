//
//  SignUpViewControllerTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

@testable import GameNews
import XCTest

class SignUpViewControllerTests: XCTestCase {

    // MARK: Subject under test

    var sut: SignUpViewController!
    var window: UIWindow!

    // MARK: Test Life Cycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupSignUpViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupSignUpViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "SignUpViewController", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Test Doubles

    class SignUpRoutingLogicSpy: SignUpRoutingLogic {

        var navigeToNewsCalled = false

        func navigateToNews(vcId: String) {
            navigeToNewsCalled = true
        }

    }

    // MARK: Tests

    func testDisplayLoginResultShouldDisplayLoginResult() {
        // Given
        let signUpRoutingLogicSpy = SignUpRoutingLogicSpy()
        sut.router = signUpRoutingLogicSpy

        let response = SignUp.Response.init(success: true)
        let viewModel = SignUp.ViewModel(success: response.success)

        // When
        sut.displaySignUpResult(viewModel: viewModel)

        // Then
        XCTAssertTrue(signUpRoutingLogicSpy.navigeToNewsCalled, "displaySignUpResult(viewModel:) should ask the view controller to navigate to news vc")
    }

    func testDisplaySignUpResultShouldNavigateToNews() {
        // Given
        let response = SignUp.Response.init(success: true)
        let viewModel = SignUp.ViewModel(success: response.success)

        // When
        loadView()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.sut.displaySignUpResult(viewModel: viewModel)

            // Then
            XCTAssertTrue(self.sut.errorLabel.alpha == 0, "displaySignUpResult(viewModel:) should ask the view controller to navigate to news vc")
        }

    }
}
