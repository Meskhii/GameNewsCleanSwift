//
//  ConfigureNewsInteractorTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

import XCTest
import SwiftSoup

@testable import GameNews

class ConfigureNewsInteractorTests: XCTestCase {

    // MARK: Subject under test

    var sut: ConfigureNewsInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupConfigureNewsInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupConfigureNewsInteractor() {
        sut = ConfigureNewsInteractor()
    }

    // MARK: Test Doubles

    class ConfigureNewsPresentationLogicSpy: ConfigureNewsPresentationLogic {

        var presentWebPagesCalled = false

        func presentWebPages(data: [WebPagesModel]) {
            presentWebPagesCalled = true
        }

    }

    // MARK: - Tests

    func testFetchWebPageOptionsShouldAskWorkerToFetchWebPageOptions() {
        // Given
        let configureNewsPresentationLogicSpy = ConfigureNewsPresentationLogicSpy()
        sut.presenter = configureNewsPresentationLogicSpy

        // When
        sut.fetchWebPageOptions()

        // Then
        XCTAssertTrue(configureNewsPresentationLogicSpy.presentWebPagesCalled, "fetch Web Page Options should ask the presenter to present Web Page Options")
    }

}
