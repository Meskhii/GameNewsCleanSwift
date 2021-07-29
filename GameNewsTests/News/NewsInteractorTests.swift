//
//  NewsInteractorTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

import XCTest
import SwiftSoup

@testable import GameNews

class NewsInteractorTests: XCTestCase {

    // MARK: Subject under test

    var sut: NewsInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupNewsInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupNewsInteractor() {
        sut = NewsInteractor()
    }

    // MARK: Test Doubles

    class NewsPresentationLogicSpy: NewsPresentationLogic {
        var presentFetchedNewsCalled = false

        func present(data: [NewsModel]) {
            presentFetchedNewsCalled = true
        }

    }

    // MARK: - Tests

    func testFetchIgnNewsShouldAskWorkerToFetchIgnNews() {
        // Given
        let newsPresentationLogicSpy = NewsPresentationLogicSpy()
        var fetchIgnNewsCalled = false
        sut.presenter = newsPresentationLogicSpy

        // When
        sut.fetchNews(webPageNames: ["ign_logo"])
        sut.ignManager.fetchNews { _ in
            fetchIgnNewsCalled = true
        }

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            XCTAssertTrue(fetchIgnNewsCalled, "fetchIgnNews should ask the worker to fetch the Ign News")
        }

    }

    func testFetchGamespotNewsShouldAskWorkerToFetchGamespotNews() {
        // Given
        let newsPresentationLogicSpy = NewsPresentationLogicSpy()
        var fetchGamespotNewsCalled = false
        sut.presenter = newsPresentationLogicSpy

        // When
        sut.fetchNews(webPageNames: ["ign_logo"])
        sut.gamespotManager.fetchNews { _ in
            fetchGamespotNewsCalled = true
        }

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            XCTAssertTrue(fetchGamespotNewsCalled, "fetchGamespotNews should ask the worker to fetch the Gamespot News")
        }
    }

    func testFetchGameInformerNewsShouldAskWorkerToFetchGameInformerNews() {
        // Given
        let newsPresentationLogicSpy = NewsPresentationLogicSpy()
        var fetchGameInformerNewsCalled = false
        sut.presenter = newsPresentationLogicSpy

        // When
        sut.fetchNews(webPageNames: ["ign_logo"])
        sut.ignManager.fetchNews { _ in
            fetchGameInformerNewsCalled = true
        }

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            XCTAssertTrue(fetchGameInformerNewsCalled, "fetchGameInfromerNews should ask the worker to fetch the GameInfromer News")
        }

    }

}
