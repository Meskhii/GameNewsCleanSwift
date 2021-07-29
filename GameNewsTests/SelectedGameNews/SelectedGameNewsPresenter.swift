//
//  SelectedGameNewsPresenter.swift
//  GameNewsTests
//
//  Created by Admin on 20.07.2021.
//

@testable import GameNews
import XCTest

class SelectedGameNewsPresenterTests: XCTestCase {
  // MARK: Subject under test

  var sut: SelectedGameNewsPresenter!

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupSelectedGameNewsPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: Test setup

  func setupSelectedGameNewsPresenter() {
    sut = SelectedGameNewsPresenter()
  }

  // MARK: Test doubles

    class SelectedGameNewsDisplayLogicSpy: SelectedGameNewsDisplayLogic {

        var displayCalled = false

        func display(data: [GameNewsModel]) {
            displayCalled = true
        }

  }

  // MARK: Tests

  func testPresentVideos() {
    // Given
    let selectedGameNewsDisplayLogicSpy = SelectedGameNewsDisplayLogicSpy()
    sut.selectedGameNewsViewController = selectedGameNewsDisplayLogicSpy

    // When
    sut.presentSelectedGameNews(with: [])

    // Then
    XCTAssertTrue(selectedGameNewsDisplayLogicSpy.displayCalled, "presentSelectedGameNews(with:) should ask the view controller to display the result")
  }

}
