//
//  LoginPresenter.swift
//  GameNewsTests
//
//  Created by Admin on 20.07.2021.
//

@testable import GameNews
import XCTest

class LoginPresenterTests: XCTestCase {
  // MARK: Subject under test

  var sut: LoginPresenter!

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupLoginPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: Test setup

  func setupLoginPresenter() {
    sut = LoginPresenter()
  }

  // MARK: Test doubles

  class LoginDisplayLogicSpy: LoginDisplayLogic {

    var displayLoginResultCalled = false

    func displayLoginResult(viewModel: Login.ViewModel) {
        displayLoginResultCalled = true
    }

  }

  // MARK: Tests

  func testPresentLoginResultShouldDisplayLoginResult() {
    // Given
    let loginDisplayLogicSpy = LoginDisplayLogicSpy()
    sut.viewController = loginDisplayLogicSpy
    let response = Login.Response.init(success: true)

    // When
    sut.presentUser(response: response)

    // Then
    XCTAssertTrue(loginDisplayLogicSpy.displayLoginResultCalled, "presentUser(response:) should ask the view controller to display the result")
  }

}
