//
//  SelectedGameNewsRouter.swift
//  GameNewsTests
//
//  Created by Admin on 23.07.2021.
//

import XCTest
@testable import GameNews

final class SelectedGameNewsRouterTests: XCTestCase {
    private var sut: SelectedGameNewsRouter!
    private var source: SourceVCMock!
    private var navigationController: UINavigationControllerMock!

    override func setUp() {
        super.setUp()

        source = SourceVCMock()
        navigationController = UINavigationControllerMock(rootViewController: source)
        sut = SelectedGameNewsRouter()
        sut.viewController = source
    }

    override func tearDown() {
        sut = nil
        source = nil
        navigationController = nil

        super.tearDown()
    }

    func testGivenRouterWhenOpenSelectedGameNewsInSafariViewThenPresentCalledOnSource() {
        sut.openSelectedGameNewsInSafariView(using: "https://www.google.com")

        XCTAssertTrue(navigationController.pushViewControllerCalled)
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
