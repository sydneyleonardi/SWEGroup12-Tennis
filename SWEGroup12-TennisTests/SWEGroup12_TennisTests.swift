//
//  SWEGroup12_TennisTests.swift
//  SWEGroup12-TennisTests
//
//  Created by Sydney Leonardi on 9/27/23.
//

import XCTest
import FirebaseAuth
@testable import SWEGroup12_Tennis // Replace "YourApp" with your app's module name

class LogInViewTests: XCTestCase {
    var view: LogInView!
    var viewModel: LogInEmailViewModel!

    @MainActor override func setUp() {
        super.setUp()
        viewModel = LogInEmailViewModel()
        view = LogInView(showSignIn: .constant(true), showCreateUser: .constant(false))
    }

    override func tearDown() {
        viewModel = nil
        view = nil
        super.tearDown()
    }

    @MainActor func testSignInButtonValidForm() {
        XCTAssertFalse(viewModel.errorAlert) // Ensure errorAlert is initially false

        let signInButton = try? view.inspect().button("Sign in")
        XCTAssertNotNil(signInButton)

        signInButton?.tap()
        XCTAssertTrue(viewModel.formIsValid) // Ensure the form is valid
        XCTAssertFalse(viewModel.errorAlert) // Ensure no error alert is shown
        XCTAssertFalse(view.showSignIn) // Ensure showSignIn is set to false
    }

    @MainActor func testSignInButtonInvalidForm() {
        XCTAssertFalse(viewModel.errorAlert) // Ensure errorAlert is initially false

        let signInButton = try? view.inspect().button("Sign in")
        XCTAssertNotNil(signInButton)

        // Provide invalid email and password
        viewModel.email = "invalidemail"
        viewModel.password = "short"

        signInButton?.tap()
        XCTAssertFalse(viewModel.formIsValid) // Ensure the form is invalid
        XCTAssertTrue(viewModel.errorAlert) // Ensure an error alert is shown
    }

    @MainActor func testFormIsValid() {
        viewModel.email = "validemail@example.com"
        viewModel.password = "securepassword"

        XCTAssertTrue(viewModel.formIsValid) // Ensure a valid form
    }

    @MainActor func testFormIsInvalid() {
        viewModel.email = "invalidemail"
        viewModel.password = "short"

        XCTAssertFalse(viewModel.formIsValid) // Ensure an invalid form
    }
}
























/*
import XCTest
import SwiftUI
import FirebaseAuth

@testable import SWEGroup12_Tennis

final class SWEGroup12_TennisTests: XCTestCase {
    
   


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    */

}
