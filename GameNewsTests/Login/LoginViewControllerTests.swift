//
//  LoginViewControllerTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

@testable import GameNews
import XCTest

class LoginViewControllerTests: XCTestCase {

    // MARK: Subject under test

    var sut: LoginViewController!
    var window: UIWindow!

    // MARK: Test Life Cycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupLoginViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupLoginViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Test Doubles

    class LoginRoutingLogicSpy: LoginRoutingLogic {

        var navigeToNewsCalled = false

        func navigateToNews(vcId: String) {
            navigeToNewsCalled = true
        }

    }

    // MARK: Tests

    func testDisplayLoginResultShouldDisplayLoginResult() {
        // Given
        let loginRoutingLogicSpy = LoginRoutingLogicSpy()
        sut.router = loginRoutingLogicSpy

        let response = Login.Response.init(success: true)
        let viewModel = Login.ViewModel(success: response.success)

        // When
        sut.displayLoginResult(viewModel: viewModel)

        // Then
        XCTAssertTrue(loginRoutingLogicSpy.navigeToNewsCalled, "displayLoginResult(viewModel:) should ask the view controller to navigate to news vc")
    }

    func testDisplayLoginResultShouldNavigateToNews() {
        // Given
        let response = Login.Response.init(success: true)
        let viewModel = Login.ViewModel(success: response.success)

        // When
        sut.displayLoginResult(viewModel: viewModel)

        // Then
        XCTAssertTrue(sut.errorLabel.alpha == 0, "displayLoginResult(viewModel:) should ask the view controller to navigate to news vc")
    }
}
