//
//  SignUpWorkerTests.swift
//  GameNewsTests
//
//  Created by user200328 on 7/11/21.
//

import Quick
import Nimble
import Mockingjay
import Foundation

@testable import GameNews

class SignUpWorkerSpec: QuickSpec {
    override func spec() {

        // MARK: - Subject Under Test (SUT)

        var sut: SignUpWorker!

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

        describe("sign up user succeeds") {
            var success = false
            let randEmail = randomEmail(length: 8)

            beforeEach {

                // when
                sut.signUpUser(firstName: Seeds.firstName, lastName: Seeds.lastName, email: randEmail, password: Seeds.password) { result in
                    success = result
                }

            }

            it("should display success result", closure: {
                // then
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    expect(success).toEventually(equal(true))
                }
            })

        }

        describe("sign up fails") {
            var success = false

            beforeEach {

                // when
                sut.signUpUser(firstName: Seeds.firstName, lastName: Seeds.lastName, email: Seeds.wrongEmail, password: Seeds.password) { result in
                    success = result
                }

            }

            it("should display fail", closure: {
                // then
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    expect(success).toEventually(equal(false))
                }
            })

        }

        // MARK: - Test Helpers

        func setupWorker() {
            sut = SignUpWorker()
        }

        func stubNetwork(as response: [String: String] = [:], status: Int = 200) {
            networkStub = stub(everything, json(response, status: status))
        }

        func randomEmail(length: Int) -> String {
          let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            return String((0..<length).map { _ in letters.randomElement()! }).appending("@gmail.com")
        }

        func removeNetworkStub() {
            if let stub = networkStub {
                removeStub(stub)
                networkStub = nil
            }
        }
    }
}
