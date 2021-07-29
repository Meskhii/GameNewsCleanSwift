//
//  LoginInteractorTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

import XCTest
import SwiftSoup

@testable import GameNews

class LoginInteractorTests: XCTestCase {

    // MARK: Subject under test

    var sut: LoginInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupLoginInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupLoginInteractor() {
        sut = LoginInteractor()
    }

    // MARK: Test Doubles

    class LoginPresentationLogicSpy: LoginPresentationLogic {

        var presentPresentUserCalled = false

        func presentUser(response: Login.Response) {
            presentPresentUserCalled = true
        }

    }

    // MARK: - Tests

    func testFetchUserShouldAskWorkerToFetchUser() {
        // Given
        let loginPresentationLogicSpy = LoginPresentationLogicSpy()
        sut.presenter = loginPresentationLogicSpy

        let loginMock = Login.Request(email: "", password: "")

        // When
        sut.fetchUser(request: loginMock)

        // Then
    //    XCTAssertTrue(loginPresentationLogicSpy.presentPresentUserCalled, "fetch User should ask the presenter to present User")
    }

}
