//
//  TabBarControllerTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

@testable import GameNews
import XCTest

class TabBarViewControllerTests: XCTestCase {

    // MARK: Subject under test

    var sut: TabBarController!
    var window: UIWindow!

    // MARK: Test Life Cycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupTabBarController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupTabBarController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "TabBarController", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
}
