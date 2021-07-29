//
//  SteamSearchGameViewControllerTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

@testable import GameNews
import XCTest

class SteamSearchGameViewControllerTests: XCTestCase {

    // MARK: Subject under test

    var sut: SteamSearchGameViewController!
    var window: UIWindow!

    // MARK: Test Life Cycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupSteamSearchGameViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupSteamSearchGameViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "SteamSearchGameViewController", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "SteamSearchGameVC") as? SteamSearchGameViewController
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

    class SteamSearchGameBusinessLogicSpy: SteamSearchGameBusinessLogic {

        var fetchSearchedGames = false

        func fetchSearchedGames(by name: String) {
            fetchSearchedGames = true
        }

    }

    // MARK: Tests

    func testShouldFetchSearchedGamesWhenViewIsLoaded() {

        // Given
        let steamSearchGameBusinessLogicSpy = SteamSearchGameBusinessLogicSpy()
        sut.interactor = steamSearchGameBusinessLogicSpy

        // When
        loadView()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            XCTAssert(steamSearchGameBusinessLogicSpy.fetchSearchedGames, "viewDidLoad() should ask the interactor fetch games")
        }

    }

    func testFetchVideoListShouldReloadTableView() {
        // Given
        loadView()

        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy

        // When
        sut.displaySearchResult(with: [])

        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "fetchSearchedGames() should reload the table view")
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

        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! SearchResultCell // swiftlint:disable:this force_cast

        // Then
        XCTAssertNotNil(cell.gameNameLabel?.text)
        XCTAssertNotNil(cell.gameReleaseDateLabel?.text)
        XCTAssertNotNil(cell.gamePriceLabel?.text)
    }

}
