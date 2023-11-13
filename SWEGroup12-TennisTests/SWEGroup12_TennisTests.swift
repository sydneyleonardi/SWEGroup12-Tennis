//
//  SWEGroup12_TennisTests.swift
//  SWEGroup12-TennisTests
//
//  Created by Sydney Leonardi on 9/27/23.
//

import XCTest
@testable import SWEGroup12_Tennis
import FirebaseAuth


// Testing Backend Capabilities
// Testing Frontend Capabilities
// Actually updating and editing database itself 

class AuthManagerTests: XCTestCase {

    var authManager: AuthManager!

    override func setUp() {
        super.setUp()
        authManager = AuthManager.shared
    }

    override func tearDown() {
        super.tearDown()
        authManager = nil
    }

    // Testing Creation of User in Auth Database

    func testCreateUser() async {
        // Provide valid test data for user creation
        let email = "auth.testing@vanderbilt.edu"
        let password = "123456789"
        
        do {
            let authDataResultModel = try await authManager.createUser(email: email, password: password)
            XCTAssertEqual(authDataResultModel.email, email)
            XCTAssertNotNil(authDataResultModel.uid)
            try authManager.signOut()
        } catch {
            XCTFail("User creation failed with error: \(error)")
        }
    }
    
    func testSignInUser() async {
        // Sign in a user with valid credentials
        let email = "auth.testing@vanderbilt.edu"
        let password = "123456789"
        
        do {
            let authDataResultModel = try await authManager.signInUser(email: email, password: password)
            XCTAssertEqual(authDataResultModel.email, email)
            XCTAssertNotNil(authDataResultModel.uid)
            
            try await authManager.signOut()
        } catch {
            XCTFail("Sign-in with valid credentials failed with error: \(error)")
        }
        
    }

    func testFetchUser() async {
            // Sign in a user for the fetchUser test
        let signInEmail = "auth.testing@vanderbilt.edu"
        let signInPassword = "123456789"
        do {
            try await authManager.signInUser(email: signInEmail, password: signInPassword)
        } catch {
            XCTFail("User sign-in failed for fetchUser test: \(error)")
        }
            
            do {
                let authDataResultModel = try authManager.fetchUser()
                XCTAssertNotNil(authDataResultModel.uid)
            } catch {
                XCTFail("User fetch failed with error: \(error)")
            }
        }

        @available(iOS 15.0, *)
        func testSignOut() async {
            do {
                try authManager.signOut()
                XCTAssertNil(Auth.auth().currentUser)
            } catch {
                XCTFail("Sign out failed with error: \(error)")
            }
        }

    @available(iOS 15.0, *)
    func testUpdatePassword() async {
        // Sign in a user for the updatePassword test
        let signInEmail = "auth.testing@vanderbilt.edu"
        let signInPassword = "123456789"
        do {
            try await authManager.signInUser(email: signInEmail, password: signInPassword)
        } catch {
            XCTFail("User sign-in failed for updatePassword test: \(error)")
        }
        
        // Provide a new password for updating
        let newPassword = "newpassword"
        
        do {
            try await authManager.updatePassword(newPassword: newPassword)
        } catch {
            XCTFail("Update password failed with error: \(error)")
        }
        
        // Sign out the user after updating the password
        do {
            try await authManager.signOut()
        } catch {
            XCTFail("Sign out after password update failed with error: \(error)")
        }
        
        // Sign in with the new password to verify the update
        do {
            try await authManager.signInUser(email: signInEmail, password: newPassword)
        } catch {
            XCTFail("Sign-in with updated password failed with error: \(error)")
        }
    }

    // this might need some more help
    @available(iOS 15.0, *)
    func testResetPassword() async {
        // Provide a valid email for password reset
        let email = "auth.testing@vanderbilt.edu"
        
        do {
            try await authManager.resetPassword(email: email)
            // Add assertions to verify that a password reset email is sent
        } catch {
            XCTFail("Password reset failed with error: \(error)")
        }
    }

        @available(iOS 15.0, *)
        func testDeleteAccount() async {
            // Sign in a user for the deleteAccount test
            let signInEmail = "auth.testing@vanderbilt.edu"
            let signInPassword = "123456789"
            do {
                try await authManager.signInUser(email: signInEmail, password: signInPassword)
            } catch {
                XCTFail("User sign-in failed for deleteAccount test: \(error)")
            }
            
            do {
                try authManager.deleteAccount()
            } catch {
                XCTFail("Delete account failed with error: \(error)")
            }
            
            // Create an expectation to wait for a short period
                let expectation = XCTestExpectation(description: "User account deletion expectation")
                // Adjust the wait time based on your test's needs
                let waitTime: TimeInterval = 10.0
                
                // Wait for the specified time to allow Firebase to process the deletion
                DispatchQueue.global().asyncAfter(deadline: .now() + waitTime) {
                    expectation.fulfill()
                }
                
                // Wait for the expectation to be fulfilled or timeout
                wait(for: [expectation], timeout: waitTime)
                
                // Check if the user is now nil (account deleted)
                XCTAssertNil(Auth.auth().currentUser)
        }
}

@MainActor
class LogInEmailViewModelTests: XCTestCase {
    
    var viewModel: LogInEmailViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LogInEmailViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    @available(iOS 15.0, *)
    func testSignInWithValidCredentials() async {
        // Provide valid test data for sign-in
        viewModel.email = "verification.test@vanderbilt.edu"
        viewModel.password = "123456789"
        
        do {
            try await viewModel.signIn()
            // Add assertions to check the expected behavior after a successful sign-in
            XCTAssertTrue(Auth.auth().currentUser?.isEmailVerified == true)
        } catch {
            XCTFail("Expected successful sign-in but got an error: \(error)")
        }
    }
    
    @available(iOS 15.0, *)
    func testSignInWithInvalidCredentials() async {
        // Provide invalid test data for sign-in
        viewModel.email = "notverified.test@vanderbilt.edu"
        viewModel.password = "123456789"
        
        do {
            try await viewModel.signIn()
            XCTFail("Expected an error for invalid credentials but sign-in was successful")
        } catch {
            // Add assertions to check the expected error type and message
            XCTAssertTrue(error is LogInEmailViewModel.VerificationError)
            XCTAssertEqual((error as? LogInEmailViewModel.VerificationError), .notVerified)
        }
    }
}


class UserManagerTests: XCTestCase {

    let userManager = UserManager.shared
    let authManager = AuthManager.shared
    let testTimeout: TimeInterval = 10 // Adjust the timeout as needed

    override func setUp() {
        // Set up any necessary configuration for testing.
    }

    override func tearDown() {
        // Clean up after each test.
    }

    func testCreateNewUser() async {
        // Provide valid test data for user creation
        let email = "user_manager_test@vanderbilt.edu"
        let password = "testpassword"

        do {
            let authDataResultModel = try await authManager.createUser(email: email, password: password)
            XCTAssertNotNil(authDataResultModel.uid)

            // Create a new user using the UserManager
            try await userManager.createNewUser(auth: authDataResultModel)

            // Verify that the user data is created in the database
            let user = try await userManager.getUser(userId: authDataResultModel.uid)
            XCTAssertEqual(user.email, email)
            XCTAssertEqual(user.userId, authDataResultModel.uid)
        } catch {
            XCTFail("User creation failed with error: \(error)")
        }
    }

    func testCreateUserProfile() async {
        // Create a new user for testing
        let email = "user_manager_test_profile@vanderbilt.edu"
        let password = "testpassword"

        do {
            let authDataResultModel = try await authManager.createUser(email: email, password: password)
            XCTAssertNotNil(authDataResultModel.uid)

            // Create a new user using the UserManager
            try await userManager.createNewUser(auth: authDataResultModel)

            // Create a user profile
            let user = DBUser(userId: authDataResultModel.uid, name: "John Doe", gender: "Male", age: "30", skillLevel: "Advanced", playType: "Singles", email: email, description: "Test user", datesSelected: [1, 2, 3], profileImageURL: "https://example.com/profile.jpg")

            // Set the user profile data
            try await userManager.createUserProfile(user: user)

            // Retrieve the user's data and verify it matches the provided data
            let fetchedUser = try await userManager.getUser(userId: authDataResultModel.uid)
            XCTAssertEqual(fetchedUser.name, user.name)
            XCTAssertEqual(fetchedUser.gender, user.gender)
            XCTAssertEqual(fetchedUser.age, user.age)
            XCTAssertEqual(fetchedUser.skillLevel, user.skillLevel)
            XCTAssertEqual(fetchedUser.playType, user.playType)
            XCTAssertEqual(fetchedUser.email, user.email)
            XCTAssertEqual(fetchedUser.description, user.description)
            XCTAssertEqual(fetchedUser.datesSelected, user.datesSelected)
            XCTAssertEqual(fetchedUser.profileImageURL, user.profileImageURL)
        } catch {
            XCTFail("Creating user profile failed with error: \(error)")
        }
    }

    func testDeleteUserData() async {
        // Create a new user for testing
        let email = "user_manager_test_delete@vanderbilt.edu"
        let password = "testpassword"

        do {
            let authDataResultModel = try await authManager.createUser(email: email, password: password)
            XCTAssertNotNil(authDataResultModel.uid)

            // Create a new user using the UserManager
            try await userManager.createNewUser(auth: authDataResultModel)

            // Delete the user's data
            userManager.deleteUserData(uid: authDataResultModel.uid)

            // Attempt to fetch the user's data should result in an error
            do {
                _ = try await userManager.getUser(userId: authDataResultModel.uid)
                XCTFail("Fetching user data should have thrown an error")
            } catch {
                if let dataError = error as? UserDataError, case .dataNotFound = dataError {
                    // Expected error
                } else {
                    XCTFail("Unexpected error: \(error)")
                }
            }
        } catch {
            XCTFail("Deleting user data failed with error: \(error)")
        }
    }

    // Add more test cases for the remaining functions as needed.
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
