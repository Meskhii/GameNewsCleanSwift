//
//  SignUpPresenter.swift
//  GameNewsTests
//
//  Created by Admin on 20.07.2021.
//

@testable import GameNews
import XCTest

class SignUpPresenterTests: XCTestCase {
  // MARK: Subject under test

  var sut: SignUpPresenter!

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupSignUpPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: Test setup

  func setupSignUpPresenter() {
    sut = SignUpPresenter()
  }

  // MARK: Test doubles

    class SignUpDisplayLogicSpy: SignUpDisplayLogic {

        var displaySignUpResultCalled = false

        func displaySignUpResult(viewModel: SignUp.ViewModel) {
            displaySignUpResultCalled = true
        }

  }

  // MARK: Tests

  func testPresentSignUpResult() {
    // Given
    let signUpDisplayLogicSpy = SignUpDisplayLogicSpy()
    sut.viewController = signUpDisplayLogicSpy
    let response = SignUp.Response.init(success: true)

    // When
    sut.presentSignUp(response: response)

    // Then
    XCTAssertTrue(signUpDisplayLogicSpy.displaySignUpResultCalled, "presentSignUp(response:) should ask the view controller to display the result")
  }

}
