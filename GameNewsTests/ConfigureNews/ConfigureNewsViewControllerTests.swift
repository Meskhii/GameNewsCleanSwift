//
//  ConfigureNewsViewControllerTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

@testable import GameNews
import XCTest

class ConfigureNewsViewControllerTests: XCTestCase {

    // MARK: Subject under test

    var sut: ConfigureNewsViewController!
    var window: UIWindow!

    // MARK: Test Life Cycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupConfigureNewsViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupConfigureNewsViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "ConfigureNewsViewController", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "ConfigureNewsViewController") as? ConfigureNewsViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Test doubles

    class CollectionViewSpy: UICollectionView {
        // MARK: Method call expectations

        var reloadDataCalled = false

        override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
            let layout = UICollectionViewLayout()
            super.init(frame: frame, collectionViewLayout: layout)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: Spied Methods

        override func reloadData() {
            super.reloadData()

            reloadDataCalled = true
        }
    }

    class ConfigureNewsBusinessLogicSpy: ConfigureNewsBusinessLogic {

        var fetchWebPageOptionsCalled = false

        func fetchWebPageOptions() {
            fetchWebPageOptionsCalled = true
        }
    }

    // MARK: Tests

    func testShouldFetchWebPageOptionsWhenViewIsLoaded() {

        // Given
        let configureNewsBusinessLogicSpy = ConfigureNewsBusinessLogicSpy()
        sut.interactor = configureNewsBusinessLogicSpy

        // When
        loadView()

        // Then
        XCTAssert(configureNewsBusinessLogicSpy.fetchWebPageOptionsCalled, "viewDidLoad() should ask the interactor to fetch web page options")

    }

    func testFetchedWebPagesShouldReloadCollectionView() {
        // Given
        loadView()

        let collectionViewSpy = CollectionViewSpy()
        sut.collectionView = collectionViewSpy

        // When
        sut.displayWebPageOptions(data: [WebPagesModel(webPageLogo: "", webPageName: "", isWebPageChecked: true)])

        // Then
        XCTAssert(collectionViewSpy.reloadDataCalled, "fetchWebPageOptions() should reload the collection view")
    }

    func testViewControllerConfiguresCollectionViewCell() {
        // When
        loadView()

        let cell = sut.collectionView(sut.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! ConfigureNewsCell // swiftlint:disable:this force_cast

        // Then
        XCTAssertNotNil(cell.webPageNameLabel.text)
    }

}
