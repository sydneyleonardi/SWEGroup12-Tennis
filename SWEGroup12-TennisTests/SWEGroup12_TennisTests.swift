//
//  SWEGroup12_TennisTests.swift
//  SWEGroup12-TennisTests
//
//  Created by Sydney Leonardi on 9/27/23.
//

import XCTest
@testable import SWEGroup12_Tennis // Import your app module

class LogInViewTests: XCTestCase {
    
    // Mocking the LogInEmailViewModel and AuthManager
    var viewModel: LogInEmailViewModel!
    var authManager: AuthManager!

    @MainActor override func setUpWithError() throws {
        // Create instances of the LogInEmailViewModel and AuthManager
        viewModel = LogInEmailViewModel()
        authManager = AuthManager.shared
    }

    override func tearDownWithError() throws {
        // Clean up resources, if needed
        viewModel = nil
        authManager = nil
    }
    
    // Test the signIn method with a successful login
    func testSignInSuccess() {
        // Simulate a successful sign-in using a mocked AuthManager
        let expectation = XCTestExpectation(description: "Sign-in success expectation")
        
        Task {
            do {
                let authDataResult = try await authManager.signInUser(email: "test@example.com", password: "password123")
                // You can add assertions to check the success state
                XCTAssertNotNil(authDataResult)
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // Test the signIn method with a failed login
    func testSignInFailure() {
        // Simulate a failed sign-in using a mocked AuthManager
        let expectation = XCTestExpectation(description: "Sign-in failure expectation")
        
        Task {
            do {
                // Attempt to sign in with incorrect credentials
                try await authManager.signInUser(email: "invalid@example.com", password: "wrongpassword")
                XCTFail("Sign-in should have failed")
            } catch {
                // You can add assertions to check the failure state
                XCTAssertTrue(true, "Sign-in failed as expected")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
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
 
 }
 */
