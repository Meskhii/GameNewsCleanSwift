//
//  VideosInteractorTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

import XCTest
import SwiftSoup

@testable import GameNews

class VideosInteractorTests: XCTestCase {

    // MARK: Subject under test

    var sut: VideosInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupVideosInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupVideosInteractor() {
        sut = VideosInteractor()
    }

    // MARK: Test Doubles

    class VideosPresentationLogicSpy: VideosPresentationLogic {

        var presentVideosCalled = false

        func presentVideos(data: [VideoCellModel]) {
            presentVideosCalled = true
        }

    }

    // MARK: - Tests

    func testFetchVideosListShouldAskWorkerToFetchVideoList() {
        // Given
        let videosPresentationLogicSpy = VideosPresentationLogicSpy()
        sut.presenter = videosPresentationLogicSpy

        // When
        sut.fetchVideosList()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertTrue(videosPresentationLogicSpy.presentVideosCalled, "fetch Video List should ask the presenter to present Video List")
        }

    }

}
