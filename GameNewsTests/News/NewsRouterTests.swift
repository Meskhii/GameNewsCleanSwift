//
//  NewsRouterTests.swift
//  GameNewsTests
//
//  Created by Admin on 23.07.2021.
//

import XCTest
@testable import GameNews

final class NewsRouterTests: XCTestCase {
    private var sut: NewsRouter!
    private var source: SourceVCMock!
    private var navigationController: UINavigationControllerMock!

    override func setUp() {
        super.setUp()

        source = SourceVCMock()
        navigationController = UINavigationControllerMock(rootViewController: source)
        sut = NewsRouter()
        sut.viewController = source
    }

    override func tearDown() {
        sut = nil
        source = nil
        navigationController = nil

        super.tearDown()
    }

    func testGivenRouterWhenOpenConfigureNewsVCThenPresentCalledOnSource() {
        sut.openConfigureNewsViewController(with: [])

        XCTAssertTrue(source.presentCalled)
    }

    func testGivenRouterWhenOpenSelectedNewsInWebViewThenPresentCalledOnSource() {
        sut.openSelectedNewsInWebView(defaultURL: "https://www.google.com/", articleURL: "")

        XCTAssertTrue(source.presentCalled)
    }

    func testGivenRouterWhenPresentShareSheetForNewsThenPresentCalledOnSource() {
        sut.presentShareSheetForNews(image: UIImage(), url: URL(string: "www.google.com")!)

        XCTAssertTrue(source.presentCalled)
    }
}

private final class UINavigationControllerMock: UINavigationController {
    var pushViewControllerCalled = false
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
    }
}

private final class SourceVCMock: UINavigationController {
    var presentCalled = false
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCalled = true
    }
}
