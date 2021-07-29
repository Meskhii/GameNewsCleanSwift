//
//  SignUpRouter.swift
//  GameNewsTests
//
//  Created by Admin on 23.07.2021.
//

import XCTest
@testable import GameNews

final class SignUpRouterTests: XCTestCase {
    private var sut: SignUpRouter!
    private var source: SourceVCMock!
    private var navigationController: UINavigationControllerMock!

    override func setUp() {
        super.setUp()

        source = SourceVCMock()
        navigationController = UINavigationControllerMock(rootViewController: source)
        sut = SignUpRouter()
        sut.viewController = source
    }

    override func tearDown() {
        sut = nil
        source = nil
        navigationController = nil

        super.tearDown()
    }

    func testGivenRouterWhenNavigateToNewsThenPresentCalledOnSource() {
        sut.navigateToNews(vcId: "TabBarController")

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
