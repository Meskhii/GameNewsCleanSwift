//
//  ProfileRouterTests.swift
//  GameNewsTests
//
//  Created by Admin on 23.07.2021.
//

import XCTest
@testable import GameNews

final class ProfileRouterTests: XCTestCase {
    private var sut: ProfileRouter!
    private var source: SourceVCMock!
    private var navigationController: UINavigationControllerMock!

    override func setUp() {
        super.setUp()

        source = SourceVCMock()
        navigationController = UINavigationControllerMock(rootViewController: source)
        sut = ProfileRouter()
        sut.viewController = source
    }

    override func tearDown() {
        sut = nil
        source = nil
        navigationController = nil

        super.tearDown()
    }

    func testGivenRouterWhenMoveUserToWelcomePageThenPresentCalledOnSource() {
        sut.moveUserToWelcomePage()

        XCTAssertTrue(source.presentCalled)
    }

    func testGivenRouterWhenOpenMailSenderThenPresentCalledOnSource() {
        sut.openMailSender(with: "Mail Sender")

        XCTAssertFalse(source.presentCalled)
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
