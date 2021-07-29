//
//  VideosPresenter.swift
//  GameNewsTests
//
//  Created by Admin on 20.07.2021.
//

@testable import GameNews
import XCTest

class VideosPresenterTests: XCTestCase {
  // MARK: Subject under test

  var sut: VideosPresenter!

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupVideosPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: Test setup

  func setupVideosPresenter() {
    sut = VideosPresenter()
  }

  // MARK: Test doubles

    class VideosDisplayLogicSpy: VideosDisplayLogic {

        var displayVideosCalled = false

        func displayVideos(_ data: [VideoCellModel]) {
            displayVideosCalled = true
        }

  }

  // MARK: Tests

  func testPresentVideos() {
    // Given
    let videosDisplayLogicSpy = VideosDisplayLogicSpy()
    sut.videosViewController = videosDisplayLogicSpy

    // When
    sut.presentVideos(data: [])

    // Then
    XCTAssertTrue(videosDisplayLogicSpy.displayVideosCalled, "presentVideos(data:) should ask the view controller to display the result")
  }

}
