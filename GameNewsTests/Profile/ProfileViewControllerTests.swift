//
//  ProfileViewControllerTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

@testable import GameNews
import XCTest

class ProfileViewControllerTests: XCTestCase {

    // MARK: Subject under test

    var sut: ProfileViewController!
    var window: UIWindow!

    // MARK: Test Life Cycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupProfileViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupProfileViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "ProfileViewController", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
}
