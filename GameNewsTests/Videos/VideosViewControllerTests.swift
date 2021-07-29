//
//  VideosViewControllerTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

@testable import GameNews
import XCTest

class VideosViewControllerTests: XCTestCase {

    // MARK: Subject under test

    var sut: VideosViewController!
    var window: UIWindow!

    // MARK: Test Life Cycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupVideosViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupVideosViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "VideosViewController", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "VideosViewController") as? VideosViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Test doubles

    class TableViewSpy: UITableView {
        // MARK: Method call expectations

        var reloadDataCalled = false

        // MARK: Spied Methods

        override func reloadData() {
            super .reloadData()
            reloadDataCalled = true
        }
    }

    class VideosBusinessLogicSpy: VideosBusinessLogic {

        var fetchVideoListCalled = false

        func fetchVideosList() {
            fetchVideoListCalled = true
        }
    }

    // MARK: Tests

    func testShouldFetchVidedoListWhenViewIsLoaded() {

        // Given
        let videosBusinessLogicSpy = VideosBusinessLogicSpy()
        sut.interactor = videosBusinessLogicSpy

        // When
        loadView()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssert(videosBusinessLogicSpy.fetchVideoListCalled, "viewDidLoad() should ask the interactor fetch video list")
        }

    }

    func testFetchVideoListShouldReloadTableView() {
        // Given
        loadView()

        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy

        // When
        sut.displayVideos([])

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssert(tableViewSpy.reloadDataCalled, "fetchVideoList() should reload the table view")
        }
    }

    func testTableRowHeightIsAutomatic() {
        // When
        loadView()

        // Then

        XCTAssertEqual(sut.tableView.rowHeight, UITableView.automaticDimension)
    }

    func testViewControllerConfiguresCellView() {

        // When
        loadView()

        sut.fetchedVideos.append(VideoCellModel(fetchedVideosTitle: "Video Title", fetchedVideosImgUrl: "", fetchedVideosId: ""))
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! VideoCell // swiftlint:disable:this force_cast

        // Then
        XCTAssertEqual(cell.videoNameLabel?.text, "Video Title")
    }

}
