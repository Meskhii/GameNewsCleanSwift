//
//  SignUpInteractorTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

import XCTest
import SwiftSoup

@testable import GameNews

class SignUpInteractorTests: XCTestCase {

    // MARK: Subject under test

    var sut: SignUpInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupSignUpInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupSignUpInteractor() {
        sut = SignUpInteractor()
    }

    // MARK: Test Doubles

    class SignUpPresentationLogicSpy: SignUpPresentationLogic {

        var signUpPresentUserCalled = false

        func presentSignUp(response: SignUp.Response) {
            signUpPresentUserCalled = true
        }

    }

    // MARK: - Tests

    func testSignUpUserShouldAskWorkerToFetchUser() {
        // Given
        let signUpPresentationLogicSpy = SignUpPresentationLogicSpy()
        sut.presenter = signUpPresentationLogicSpy

        let signUp = SignUp.Request(firstName: "", lastName: "", email: "", password: "")

        // When
        sut.signUpUser(request: signUp)

        // Then
      //  XCTAssertTrue(signUpPresentationLogicSpy.signUpPresentUserCalled, "Sign Up User should ask the presenter to present Sign Up")
    }

}
