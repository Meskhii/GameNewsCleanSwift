//
//  SelectedGameNewsInteractorTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

import XCTest
import SwiftSoup

@testable import GameNews

class SelectedGameNewsInteractorTests: XCTestCase {

    // MARK: Subject under test

    var sut: SelectedGameNewsInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupSelectedGameNewsInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupSelectedGameNewsInteractor() {
        sut = SelectedGameNewsInteractor()
    }

    // MARK: Test Doubles

    class SelectedGameNewsPresentationLogicSpy: SelectedGameNewsPresentationLogic {

        var presentSelectedGameNewsCalled = false

        func presentSelectedGameNews(with data: [GameNewsModel]) {
            presentSelectedGameNewsCalled = true
        }

    }

    // MARK: - Tests

    func testFetchSearchedGameNewsShouldAskWorkerToFetchSearchedGameNews() {
        // Given
        let selectedGameNewsPresentationLogicSpy = SelectedGameNewsPresentationLogicSpy()
        sut.presenter = selectedGameNewsPresentationLogicSpy

        // When
        sut.fetchSelectedGameNews(appId: "")
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) {
            XCTAssertTrue(selectedGameNewsPresentationLogicSpy.presentSelectedGameNewsCalled, "fetch Searched Game News should ask the presenter to present Searched Game news")
        }
    }

}
