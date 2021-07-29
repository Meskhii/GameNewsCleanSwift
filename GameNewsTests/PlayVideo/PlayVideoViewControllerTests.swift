//
//  PlayVideoTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

@testable import GameNews
import XCTest

class PlayVideoViewControllerTests: XCTestCase {

    // MARK: Subject under test
    var sut: PlayVideoViewController!
    var window: UIWindow!

    // MARK: Test Life Cycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupPlayVideoViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupPlayVideoViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "PlayVideoViewController", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "PlayVideoViewController") as? PlayVideoViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // Tests

    func testLoadView() {
        loadView()
    }

}
