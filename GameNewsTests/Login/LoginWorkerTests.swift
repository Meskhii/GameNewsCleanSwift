//
//  LoginWorkerTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

import Quick
import Nimble
import Mockingjay

@testable import GameNews

class LoginWorkerSpec: QuickSpec {
    override func spec() {

        // MARK: - Subject Under Test (SUT)

        var sut: LoginWorker!

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

        describe("login user") {
            var success = false

            beforeEach {

                // when
                sut.login(email: Seeds.wrongEmail, password: Seeds.password) { result in
                    success = result
                }

            }

            it("should display the login result", closure: {
                // then
                expect(success).toEventually(equal(false))
            })

        }

        // MARK: - Test Helpers

        func setupWorker() {
            sut = LoginWorker()
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
