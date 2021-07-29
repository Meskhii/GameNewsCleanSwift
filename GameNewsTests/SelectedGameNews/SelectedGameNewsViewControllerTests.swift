//
//  SelectedGameNewsViewControllerTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

@testable import GameNews
import XCTest

class SelectedGameNewsViewControllerTests: XCTestCase {

    // MARK: Subject under test

    var sut: SelectedGameNewsViewController!
    var window: UIWindow!

    // MARK: Test Life Cycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupSelectedGameNewsViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupSelectedGameNewsViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "SelectedGameNewsViewController", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "SelectedGameNewsViewController") as? SelectedGameNewsViewController
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

    class SelectedGameNewsBusinessLogicSpy: SelectedGameNewsBusinessLogic {

        var fetchSelectedGameNewsCalled = false

        func fetchSelectedGameNews(appId: String) {
            fetchSelectedGameNewsCalled = true
        }
    }

    // MARK: Tests

    func testShouldFetchSelectedGameNewsWhenViewIsLoaded() {

        // Given
        let selectedGameNewsBusinessLogicSpy = SelectedGameNewsBusinessLogicSpy()
        sut.interactor = selectedGameNewsBusinessLogicSpy

        // When
        loadView()

        // Then
        XCTAssert(selectedGameNewsBusinessLogicSpy.fetchSelectedGameNewsCalled, "viewDidLoad() should ask the interactor fetch selected game news")

    }

    func testFetchSelectedGameNewsShouldReloadTableView() {
        // Given
        loadView()

        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy

        // When
        sut.display(data: [])

        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "fetchSelectedGameNews() should reload the table view")
    }

    func testViewControllerConfiguresCellView() {

        // Given
        let mockData = GameNewsModel(title: "News Title", url: "", author: "Author Label", contents: "Content Label")

        sut.selectedGameNews.append(mockData)

        // When
        loadView()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let cell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! SelectedGameNewsCell // swiftlint:disable:this force_cast

            // Then
            XCTAssertEqual(cell.titleLabel?.text, "News Title")
            XCTAssertEqual(cell.authorLabel?.text, "Author Label")
            XCTAssertEqual(cell.contentLabel?.text, "Content Label")
        }

    }

}
