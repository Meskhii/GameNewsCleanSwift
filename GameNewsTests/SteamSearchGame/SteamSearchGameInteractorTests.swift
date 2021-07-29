//
//  SteamSearchGameInteractorTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

import XCTest
import SwiftSoup

@testable import GameNews

class SteamSearchGameInteractorTests: XCTestCase {

    // MARK: Subject under test

    var sut: SteamSearchGameInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupSteamSearchGameInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupSteamSearchGameInteractor() {
        sut = SteamSearchGameInteractor()
    }

    // MARK: Test Doubles

    class SteamSearchGamePresentationLogicSpy: SteamSearchGamePresentationLogic {

        var presentSearchResultsCalled = false

        func presentSearchResult(with data: SearchResultModel) {
            presentSearchResultsCalled = true
        }

    }

    // MARK: - Tests

    func testFetchSearchedGamesShouldAskWorkerToFetchSearchedGames() {
        // Given
        let steamSearchGamePresentationLogicSpy = SteamSearchGamePresentationLogicSpy()
        sut.presenter = steamSearchGamePresentationLogicSpy

        // When
        sut.fetchSearchedGames(by: "")

        // Then
        XCTAssertTrue(steamSearchGamePresentationLogicSpy.presentSearchResultsCalled, "fetch Searched Games should ask the presenter to present Search Result")
    }

}
