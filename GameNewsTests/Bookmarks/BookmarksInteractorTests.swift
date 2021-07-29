//
//  BookmarksInteractorTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

import XCTest
import SwiftSoup

@testable import GameNews

class BookmarksInteractorTests: XCTestCase {

    // MARK: Subject under test

    var sut: BookmarksInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupBookmarksInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupBookmarksInteractor() {
        sut = BookmarksInteractor()
    }

    // MARK: Test Doubles

    class BookmarksPresentationLogicSpy: BookmarksPresentationLogic {

        var presentBookmarksCalled = false
        func present(bookmarks: [[String: Any]]) {
            presentBookmarksCalled = true
        }

    }

    // MARK: - Tests

    func testFetchBookmarkedNewsShouldAskWorkerToFetchBookmarkedNews() {
        // Given
        let bookmarksPresentationLogicSpy = BookmarksPresentationLogicSpy()
        sut.presenter = bookmarksPresentationLogicSpy

        // When
        sut.fetchBookmarkedNews()
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 20.0) {
            XCTAssertTrue(bookmarksPresentationLogicSpy.presentBookmarksCalled, "fetch Bookmarked News should ask the presenter to present Bookmarked News")
        }
    }

}
