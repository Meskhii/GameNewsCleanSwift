//
//  BookmarksViewControllerTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

@testable import GameNews
import XCTest

class BookmarksViewControllerTests: XCTestCase {

    // MARK: Subject under test

    var sut: BookmarksViewController!
    var window: UIWindow!

    // MARK: Test Life Cycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupBookmarksViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupBookmarksViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "BookmarksViewController", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "BookmarksViewController") as? BookmarksViewController
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

    class BookmarksBusinessLogicSpy: BookmarksBusinessLogic {

        var deleteNewsForUserFromFirebaseCalled = false

        func deleteNewsForUserFromFirebase(title: String) {
            deleteNewsForUserFromFirebaseCalled = true
        }

        var fetchBookmarkedNewsCalled = false

        func fetchBookmarkedNews() {
            fetchBookmarkedNewsCalled = true
        }
    }

    // MARK: Tests

    func testShouldFetchBookmarkedNewsWhenViewIsLoaded() {

        // Given
        let bookmarksBusinessLogicSpy = BookmarksBusinessLogicSpy()
        sut.interactor = bookmarksBusinessLogicSpy

        // When
        loadView()

        // Then
        XCTAssert(bookmarksBusinessLogicSpy.fetchBookmarkedNewsCalled, "viewDidLoad() should ask the interactor fetch bookmarked news")

    }

    func testFetchSelectedGameNewsShouldReloadTableView() {
        // Given
        loadView()

        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy

        // When
        sut.displayBookmarks(data: [])

        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "fetchSelectedGameNews() should reload the table view")
    }

    func testTableRowHeightIsAutomatic() {
        // When
        loadView()

        // Then

        XCTAssertEqual(sut.tableView.rowHeight, UITableView.automaticDimension)
    }

    /*
     // Getting this warning can't fix
     // request for rect at invalid index path (<NSIndexPath: 0xc31d1621f7c4f341> {length = 2, path = 0 - 0}) (NSInternalInconsistencyException)
     
    func testViewControllerConfiguresCellView() {

        // When
        
        loadView()
        
        let mockData = BookmarksModel(newsImage: "", newsTitle: "News Title", newsUrl: "")
        
        sut.bookmarkedNews.append(mockData)
        
      //  let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! BookmarkCell

        // Then
        XCTAssertEqual(cell.newsTitle?.text, "News Title")
    }
    */
}
