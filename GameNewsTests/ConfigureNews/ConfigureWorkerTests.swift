//
//  ConfigureWorkerTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

import Quick
import Nimble
import Mockingjay

@testable import GameNews

class ConfigureNewsWorkerSpec: QuickSpec {
    override func spec() {

        // MARK: - Subject Under Test (SUT)

        var sut: ConfigureNewsWorker!

        // MARK: - Test Doubles

        var networkStub: Stub!

        // MARK: - Tests

        beforeEach {
            setupWorker()
        }

        afterEach {
            removeNetworkStub()
            sut = nil
        }

        // MARK: Use Cases

        describe("fetch web page options data") {
            var fetchedWebPages = [WebPagesModel]()

            beforeEach {

                // when
                fetchedWebPages = sut.mockFetchedWebPages()
            }

            it("should count the fetched web pages more then one", closure: {
                // then
                expect(fetchedWebPages.count).toEventually(beGreaterThanOrEqualTo(1))
            })

        }

        // MARK: - Test Helpers

        func setupWorker() {
            sut = ConfigureNewsWorker()
        }

        func stubNetwork(as response: [String: String] = [:], status: Int = 200) {
            networkStub = stub(everything, json(response, status: status))
        }

        func removeNetworkStub() {
            if let stub = networkStub {
                removeStub(stub)
                networkStub = nil
            }
        }
    }
}
