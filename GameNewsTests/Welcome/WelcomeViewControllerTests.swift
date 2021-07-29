//
//  WelcomeViewControllerTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

@testable import GameNews
import XCTest

class WelcomeViewControllerTests: XCTestCase {

    // MARK: Subject under test

    var sut: WelcomeViewController!
    var window: UIWindow!

    // MARK: Test Life Cycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupWelcomeViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupWelcomeViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "WelcomeViewController", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Test Doubles

    class WelcomeRoutingLogicSpy: WelcomeRoutingLogic {

        var navigateToSignUpCalled = false

        func navigateToSignUp(vcId: String) {
            navigateToSignUpCalled = true
        }

        var navigateToLoginCalled = false

        func navigateToLogin(vcId: String) {
            navigateToLoginCalled = true
        }

        var navigateToNewsCalled = false

        func navigateToNews(vcId: String) {
            navigateToNewsCalled = true
        }

    }

    // MARK: Tests

    func testLoginButtonPressShouldCallNavigateToLogin() {

        // Given
        loadView()

        let welcomeRoutingLogicSpy = WelcomeRoutingLogicSpy()
        sut.router = welcomeRoutingLogicSpy

        // When
        sut.loginButton.sendActions(for: .touchUpInside)

        // Then
        XCTAssert(welcomeRoutingLogicSpy.navigateToLoginCalled, "loginButton.sendActions(for: .touchUpInside) should navigate user to login vc")
    }

    func testSignUpButtonPressShouldCallNavigateToSignUp() {

        // Given
        loadView()

        let welcomeRoutingLogicSpy = WelcomeRoutingLogicSpy()
        sut.router = welcomeRoutingLogicSpy

        // When
        sut.signUpButton.sendActions(for: .touchUpInside)

        // Then
        XCTAssert(welcomeRoutingLogicSpy.navigateToSignUpCalled, "signUpButton.sendActions(for: .touchUpInside) should navigate user to sign up vc")
    }

}
