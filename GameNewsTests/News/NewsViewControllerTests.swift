//
//  NewsViewControllerTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

@testable import GameNews
import XCTest

class NewsViewControllerTests: XCTestCase {

    // MARK: Subject under test

    var sut: NewsViewController!
    var window: UIWindow!

    // MARK: Test Life Cycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupNewsViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupNewsViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "NewsViewController", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as? NewsViewController
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

    class NewsBusinessLogicSpy: NewsBusinessLogic {

        var fetchNewsCalled = false

        func fetchNews(webPageNames: [String]) {
            fetchNewsCalled = true
        }
    }

    class NewsRoutingLogicSpy: NewsRoutingLogic {

        var openSelectedNewsInWebViewCalled = false
        func openSelectedNewsInWebView(defaultURL: String, articleURL: String) {
            openSelectedNewsInWebViewCalled = true
        }

        var openConfigureNewsVCCalled = false
        func openConfigureNewsViewController(with webPages: [WebPagesModel]) {
            openConfigureNewsVCCalled = true
        }

        var presentShareSheetForNewsCalled = false
        func presentShareSheetForNews(image: UIImage, url: URL) {
            presentShareSheetForNewsCalled = true
        }

    }

    // MARK: Tests

    func testGetFetchedNewsShouldReloadTableView() {
        // Given
        loadView()

        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy

        // When
        sut.display(data: [])

        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "fetchNews() should reload the table view")
    }

    func testTableRowHeightIsAutomatic() {

        // When
        loadView()

        // Then
        XCTAssertEqual(sut.tableView.rowHeight, UITableView.automaticDimension)
    }

    func testViewControllerConfiguresCollectionViewCell() {
        // When
        loadView()

        let cell = sut.collectionView(sut.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! WebPagesCell // swiftlint:disable:this force_cast

        // Then
        XCTAssertNotNil(cell.webSitesButton.title(for: .normal))
    }

    func testPresentShareSheetShouldPresentShareSheetForNews() {

        // Given
        loadView()

        let newsRoutingLogicSpy = NewsRoutingLogicSpy()
        sut.router = newsRoutingLogicSpy

        // When
        sut.presentShareSheet(using: UIImage(), url: URL(string: "www.google.com")!)

        // Then
        XCTAssert(newsRoutingLogicSpy.presentShareSheetForNewsCalled, "presentShareSheet(using: , url: ) should present share sheet for news")
    }

    func testCollectionViewDidSelectItemAtFirstIndexShouldCallOpenConfigureNewsVC() {

        // Given
        loadView()

        let newsRoutingLogicSpy = NewsRoutingLogicSpy()
        sut.router = newsRoutingLogicSpy

        // When
        sut.collectionView(sut.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))

        // Then
        XCTAssert(newsRoutingLogicSpy.openConfigureNewsVCCalled, "sut.collectionView(sut.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0)) should open configure news vc")
    }

    func testTableViewDidSelectRowAtShouldOpenSelectedNewsInWebView() {

        // Given
        loadView()

        let newsRoutingLogicSpy = NewsRoutingLogicSpy()
        sut.router = newsRoutingLogicSpy

        // When

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            self.sut.tableView(self.sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

            XCTAssert(newsRoutingLogicSpy.openSelectedNewsInWebViewCalled, "sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0)) should navigate user to sign up vc")
        }

    }

}
