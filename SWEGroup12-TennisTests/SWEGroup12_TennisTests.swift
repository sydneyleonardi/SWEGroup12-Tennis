//
//  SWEGroup12_TennisTests.swift
//  SWEGroup12-TennisTests
//
//  Created by Sydney Leonardi on 9/27/23.
//

import XCTest
@testable import SWEGroup12_Tennis
import FirebaseAuth


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

@MainActor
class LoginTests: XCTestCase {

    let authManager = AuthManager.shared
    let testTimeout: TimeInterval = 10 // Adjust the timeout as needed

    override func setUp() {
        // Set up any necessary configuration for testing.
    }

    override func tearDown() {
        // Clean up after each test.
    }

    func testSuccessfulLogin() async {
        // Provide valid test data for a successful login
        let email = "auth.testing@vanderbilt.edu"
        let password = "123456789"

        do {
            // Create a user for testing
            let authDataResultModel = try await authManager.createUser(email: email, password: password)
            XCTAssertNotNil(authDataResultModel.uid)

            // Perform the login
            let viewModel = LogInEmailViewModel()
            viewModel.email = email
            viewModel.password = password

            do {
                try await viewModel.signIn()

                // Check if the user is signed in
                let user = Auth.auth().currentUser
                XCTAssertTrue(user?.isEmailVerified == true)

                // Perform additional assertions as needed
            } catch {
                XCTFail("Successful login failed with error: \(error)")
            }
        } catch {
            XCTFail("User creation failed with error: \(error)")
        }
    }

    func testUnverifiedLogin() async {
        // Provide valid test data for an unverified login
        let email = "auth.testing@vanderbilt.edu"
        let password = "123456789"

        do {
            // Create a user for testing, but don't verify the email
            let authDataResultModel = try await authManager.createUser(email: email, password: password)
            XCTAssertNotNil(authDataResultModel.uid)

            // Perform the login
            let viewModel = LogInEmailViewModel()
            viewModel.email = email
            viewModel.password = password

            do {
                try await viewModel.signIn()

                // Since the user's email is not verified, this login should fail
                XCTFail("Unverified login should have thrown a VerificationError")
            } catch {
                if let verificationError = error as? LogInEmailViewModel.VerificationError,
                   case .notVerified = verificationError {
                    // Expected error for unverified login
                } else {
                    XCTFail("Unexpected error: \(error)")
                }
            }
        } catch {
            XCTFail("User creation failed with error: \(error)")
        }
    }
    func testInvalidEmail() async {
        // Provide an invalid email for login
        let email = "invalid_email"
        let password = "123456789"

        // Perform the login with an invalid email
        let viewModel = LogInEmailViewModel()
        viewModel.email = email
        viewModel.password = password

        do {
            try await viewModel.signIn()

            // This login should fail due to an invalid email
            XCTFail("Login with an invalid email should have thrown an error")
        } catch {
            // Check if the error is due to an invalid email
                XCTFail("Unexpected error: \(error)")
            }
    }

    func testShortPassword() async {
        // Provide a password that is too short for login
        let email = "auth.testing@vanderbilt.edu"
        let password = "12345" // Password length is less than 8

        // Perform the login with a short password
        let viewModel = LogInEmailViewModel()
        viewModel.email = email
        viewModel.password = password

        do {
            try await viewModel.signIn()

            // This login should fail due to a short password
            XCTFail("Login with a short password should have thrown an error")
        } catch {
            // Check if the error is due to a short password
                XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testEmptyEmailAndPassword() async {
        // Provide empty email and password
        let email = ""
        let password = ""

        // Create a view model and set email and password
        let viewModel = LogInEmailViewModel()
        viewModel.email = email
        viewModel.password = password

        do {
            try await viewModel.signIn()
            XCTFail("Login with empty email and password should have failed.")
        } catch {
            // Verify that an error message is displayed for empty fields
            XCTFail("Email and/or password are invalid")
        }
    }
    
}

@MainActor
class SignUpViewTests: XCTestCase {
    
    func testFormIsValid() {
        let viewModel = SignUpEmailViewModel()
        
        // Valid form input
        viewModel.email = "valid_email@vanderbilt.edu"
        viewModel.password = "validpassword"
        viewModel.confirmPassword = "validpassword"
        
        let signUpView = SignUpView()
        XCTAssertTrue(signUpView.formIsValid)
        
        // Invalid email format
        viewModel.email = "invalidemail"
        XCTAssertFalse(signUpView.formIsValid)
        
        // Short password
        viewModel.email = "valid_email@vanderbilt.edu"
        viewModel.password = "short"
        XCTAssertFalse(signUpView.formIsValid)
        
        // Mismatched passwords
        viewModel.password = "validpassword"
        viewModel.confirmPassword = "mismatchedpassword"
        XCTAssertFalse(signUpView.formIsValid)
        
        // Empty fields
        viewModel.password = ""
        viewModel.confirmPassword = ""
        XCTAssertFalse(signUpView.formIsValid)
    }
}

@MainActor
class SignUpEmailViewModelTests: XCTestCase {
    
    func testSignUpWithValidCredentials() async {
        let viewModel = SignUpEmailViewModel()
        
        viewModel.email = "valid_email@vanderbilt.edu"
        viewModel.password = "validpassword"
        viewModel.confirmPassword = "validpassword"
        
        do {
            try await viewModel.signUp()
            
            // Add appropriate assertions to verify a successful signup
        } catch {
            XCTFail("Failed to sign up with valid credentials: \(error)")
        }
    }
    
    func testSignUpWithUsedEmail() async {
        let viewModel = SignUpEmailViewModel()
        
        viewModel.email = "used_email@vanderbilt.edu"
        viewModel.password = "validpassword"
        viewModel.confirmPassword = "validpassword"
        
        do {
            try await viewModel.signUp()
            
            // Add appropriate assertions to verify an email already in use error
        } catch AuthErrorCode.emailAlreadyInUse {
            // This is expected
        } catch {
            XCTFail("Unexpected error during signup: \(error)")
        }
    }
}




class MockFirestore {
    var didUpdateData = false
    var updatedDocumentID: String = ""
    var updatedData: [String: Any] = [:]

    func collection(_ path: String) -> MockFirestore {
        // You might need to handle nested collections depending on your implementation
        return self
    }

    func document(_ documentPath: String) -> MockFirestore {
        // You might need to handle specific document references depending on your implementation
        return self
    }

    func updateData(_ data: [String: Any], completion: @escaping (Error?) -> Void) {
        didUpdateData = true
        updatedData = data
        // Simulate completion or error handling if needed
        completion(nil)
    }
}

class CalendarResViewTests: XCTestCase {
    
    func testCalendarResView_InitialState() {
        let viewModel = ResViewModel()
        let view = CalendarResView(resVM: viewModel)
        
        //XCTAssertEqual(view.selectedDate, Date())
        XCTAssertTrue(view.availableRes)
        XCTAssertFalse(view.availableResExist)
        XCTAssertEqual(view.courtNum, "1")
    }
    
    func testResViewModel_FetchRes() {
        let viewModel = ResViewModel()
        let courtNum = "1"
        
        viewModel.fetchRes(courtNum: courtNum)
        
        // You can write assertions here to verify the behavior of the fetchRes method.
        

            func testFetchRes() {
                // Assuming initially the reservations array is empty
                XCTAssertTrue(viewModel.reservations.isEmpty)

                // Fetch reservations for court 1
                viewModel.fetchRes(courtNum: "1")

                // After fetch, the reservations array should not be empty
                XCTAssertFalse(viewModel.reservations.isEmpty)

                // Assuming you're fetching reservations for court 1 and the fetched reservation has the same court number
                XCTAssertEqual(viewModel.reservations.first?.court, "1")

                // Perform more assertions based on your business logic and what is expected from fetchRes method
            }
        

    }
}



class CalendarResViewTests3: XCTestCase {

    var calendarResView: CalendarResView!
    var resViewModel: ResViewModel!

    override func setUp() {
        super.setUp()

        calendarResView = CalendarResView()
        resViewModel = ResViewModel()
        calendarResView.resVM = resViewModel
    }

    override func tearDown() {
        calendarResView = nil
        resViewModel = nil

        super.tearDown()
    }

    func testInitialCourtNumber() {
        XCTAssertEqual(calendarResView.courtNum, "1")
    }

    func testSelectedDate() {
        let today = Date()
        XCTAssertEqual(calendarResView.selectedDate.timeIntervalSince1970, today.timeIntervalSince1970, accuracy: 1.0)
    }

    func testChangeAvailableReservations() {
        calendarResView.availableRes = false
        calendarResView.yourResExist = true
        XCTAssertEqual(calendarResView.availableRes, false)
        XCTAssertEqual(calendarResView.yourResExist, true)
    }

    // Test fetchRes method from ResViewModel

    func testFetchRes() {
        calendarResView.resVM.fetchRes(courtNum: "1")
        XCTAssertEqual(calendarResView.resVM.reservations.count, 0)
    }
}



class ResTimeViewTests: XCTestCase {
    
    func testResTimeView_InitialState() {
        let viewModel = ResViewModel()
        let view = ResTimeView(resVM: viewModel)
        
        XCTAssertEqual(view.name, "")
        XCTAssertEqual(view.email, "")
        XCTAssertEqual(view.courtNum, "")
        XCTAssertEqual(view.time, "")
        XCTAssertEqual(view.date, "")
        XCTAssertEqual(view.id, "")
    }
    
    func testResViewModel_MakeRes() {
        let viewModel = ResViewModel()
        let id = "someId"
        let player = "John Doe"
        let courtNum = "1"
        
        viewModel.makeRes(id: id, player: player, courtNum: courtNum)
        
        // You can write assertions here to verify the behavior of the makeRes method.
        
        var resViewModel: ResViewModel!
        var mockFirestore: MockFirestore! // Create a mock for Firestore
        
        func setUp() {
            super.setUp()
            mockFirestore = MockFirestore() // Initialize your mock Firestore
            resViewModel = ResViewModel()
            //resViewModel.db = mockFirestore // Inject the mock Firestore
            // Set up any initial conditions if needed
        }
        
        func tearDown() {
            // Clean up after each test if needed
            mockFirestore = nil
            resViewModel = nil
            super.tearDown()
        }
        
        func testMakeRes() {
            // Define your expected data
            let id = "12345"
            let player = "TestPlayer"
            let courtNum = "1"
            // Run the function
            resViewModel.makeRes(id: id, player: player, courtNum: courtNum)
            
            // Verify if the correct data was sent to Firestore
            // For example, if your mock Firestore has a property to store the written data, check it here
            
            // Assert the mockFirestore method call with expected parameters
            XCTAssertTrue(mockFirestore.didUpdateData) // Assuming you have a flag in the mock indicating if updateData was called
            XCTAssertEqual(mockFirestore.updatedDocumentID, id)
            XCTAssertEqual(mockFirestore.updatedData["reserved"] as? Bool, true)
            XCTAssertEqual(mockFirestore.updatedData["player"] as? String, player)
        }
    }
}
    
    
    class ResConfirmationViewTests: XCTestCase {
        
        func testResConfirmationView_InitialState() {
            let view = ResConfirmationView(name: "John Doe", courtNum: "1", time: "12:00 PM - 1:00 PM", date: "2023-11-01")
            
            // Write assertions to verify the initial state of the view.
        }
    }
    
    
    class ResViewModelTests: XCTestCase {
        var resViewModel: ResViewModel!
        
        override func setUp() {
            super.setUp()
            resViewModel = ResViewModel()
            // Set up any initial conditions like database mocks, if needed
        }
        
        override func tearDown() {
            // Clean up after each test if needed
            resViewModel = nil
            super.tearDown()
        }
        
        func testResViewModel_InitialState() {
            let viewModel = ResViewModel()
            
            XCTAssertEqual(viewModel.reservations, [])
        }
        
        func testResViewModel_FetchRes() {
            let viewModel = ResViewModel()
            let courtNum = "1"
            
            viewModel.fetchRes(courtNum: courtNum)
            
            // You can write assertions here to verify the behavior of the fetchRes method.
            func testFetchRes() {
                    let courtNumber = "1"
                    
                    // Initially, the reservations array should be empty
                    XCTAssertTrue(resViewModel.reservations.isEmpty)

                    // Call the fetchRes method
                    resViewModel.fetchRes(courtNum: courtNumber)

                    // After fetching reservations, the reservations array should not be empty
                    XCTAssertFalse(resViewModel.reservations.isEmpty)

                    // Assuming you're fetching reservations for court 1, check if the fetched reservations are for the correct court
                    let fetchedReservationsForCourt1 = resViewModel.reservations.filter { $0.court == courtNumber }
                    XCTAssertEqual(fetchedReservationsForCourt1.count, 2) // Assuming two mock reservations were added

                    // You can further assert other properties or conditions of the fetched reservations
                    // For instance, check if a reservation with a specific player name exists
                    let reservedByJohnDoe = resViewModel.reservations.contains { $0.player == "John Doe" }
                    XCTAssertTrue(reservedByJohnDoe)
                }
            
            func testFetchResProperties() {
                let courtNumber = "1"
                let expectedReservationsCount = 1

                // Initially, the reservations array should be empty
                XCTAssertTrue(resViewModel.reservations.isEmpty)

                // Call the fetchRes method
                resViewModel.fetchRes(courtNum: courtNumber)

                // After fetching reservations, the reservations array should not be empty
                XCTAssertFalse(resViewModel.reservations.isEmpty)

                // Check if all the fetched reservations belong to the requested court
                XCTAssertTrue(resViewModel.reservations.allSatisfy { $0.court == courtNumber })

                // Ensure that only reservations for the requested court are fetched
                let otherCourtReservations = resViewModel.reservations.filter { $0.court != courtNumber }
                XCTAssertTrue(otherCourtReservations.isEmpty)

                // Verify the count of fetched reservations
                XCTAssertEqual(resViewModel.reservations.count, expectedReservationsCount)
                
                // Ensure the 'reserved' property for each reservation is accurate
                XCTAssertTrue(resViewModel.reservations.allSatisfy { $0.reserved == true || $0.reserved == false })

                // Ensure that if a reservation is marked as reserved, the player property is not empty
                let reservedWithEmptyPlayer = resViewModel.reservations.filter { $0.reserved && $0.player.isEmpty }
                XCTAssertTrue(reservedWithEmptyPlayer.isEmpty)
            }
            
            func testFetchResSorting() {
                let courtNumber = "1"

                // Initially, the reservations array should be empty
                XCTAssertTrue(resViewModel.reservations.isEmpty)

                // Call the fetchRes method
                resViewModel.fetchRes(courtNum: courtNumber)

                // After fetching reservations, the reservations array should not be empty
                XCTAssertFalse(resViewModel.reservations.isEmpty)

                // Ensure the fetched reservations are in sorted order by start time
                let sortedByStart = resViewModel.reservations.sorted { $0.start < $1.start }
                XCTAssertEqual(resViewModel.reservations, sortedByStart)

                // Ensure that the fetched reservations have valid start and end times
                let validStartEndTimes = resViewModel.reservations.allSatisfy {
                    $0.start < $0.end
                }
                XCTAssertTrue(validStartEndTimes)

                // Verify that the fetched reservations are for dates after the current date
                let currentDate = Date()
                let datesInPast = resViewModel.reservations.filter {
                    $0.date < currentDate.formatted(date: .numeric, time: .omitted)
                }
                XCTAssertTrue(datesInPast.isEmpty)

                // Test the behavior when trying to fetch reservations for an invalid court number
                resViewModel.fetchRes(courtNum: "5")
                // The fetched reservations should still be empty for an invalid court number
                XCTAssertTrue(resViewModel.reservations.isEmpty)
            }
            
            func testFetchResValidity() {
                let courtNumber = "1"

                // Initially, the reservations array should be empty
                XCTAssertTrue(resViewModel.reservations.isEmpty)

                // Call the fetchRes method
                resViewModel.fetchRes(courtNum: courtNumber)

                // After fetching reservations, the reservations array should not be empty
                XCTAssertFalse(resViewModel.reservations.isEmpty)

                // Test if the fetched reservations contain the expected court number
                let validCourtNumber = resViewModel.reservations.allSatisfy { $0.court == courtNumber }
                XCTAssertTrue(validCourtNumber)

                // Test if fetched reservations do not contain other court numbers
                let invalidCourtNumber = resViewModel.reservations.first { $0.court != courtNumber }
                XCTAssertNil(invalidCourtNumber)

                // Ensure that the fetched reservations do not exceed the specified limit
                let fetchLimit = 20 // Assuming a limit of 20 reservations
                XCTAssertLessThanOrEqual(resViewModel.reservations.count, fetchLimit)

                // Verify that the fetched reservations are associated with the current user
//                let currentUserReservations = resViewModel.reservations.allSatisfy { $0.player == resViewModel.currentUser }
//                XCTAssertTrue(currentUserReservations)
            }
            
            func testFetchResValidity2() {
                // ...

                // Ensure that the fetched reservations are for the selected court only
//                for reservation in resViewModel.reservations {
//                    if resViewModel.currentCourtNum != nil {
//                        XCTAssertEqual(reservation.court, resViewModel.currentCourtNum)
//                    }
//                }

                // Test if the fetched reservations are not empty
                XCTAssertFalse(resViewModel.reservations.isEmpty)

                // Assert that the fetched reservations have valid date formats
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                for reservation in resViewModel.reservations {
                    XCTAssertNotNil(dateFormatter.date(from: reservation.start))
                    XCTAssertNotNil(dateFormatter.date(from: reservation.end))
                }

                // Check that the fetched reservations array is within a reasonable size range
                XCTAssertGreaterThan(resViewModel.reservations.count, 0)
                XCTAssertLessThanOrEqual(resViewModel.reservations.count, 100)

                // Verify that fetched reservations are not nil
                XCTAssertNotNil(resViewModel.reservations)

                // Verify that the fetched reservations aren't already marked as reserved
                let alreadyReserved = resViewModel.reservations.allSatisfy { $0.reserved }
                XCTAssertFalse(alreadyReserved)
            }
            
        }
        
        func testResViewModel_MakeRes() {
            let resViewModel = ResViewModel()
            let id = "someId"
            let player = "John Doe"
            let courtNum = "1"
            
            resViewModel.makeRes(id: id, player: player, courtNum: courtNum)
            
            // You can write assertions here to verify the behavior of the makeRes method.
            func testMakeRes() {
                // Create a XCTestExpectation to wait for the Firestore call to complete
                let expectation = expectation(description: "Make reservation")

                let id = "12345"
                let player = "TestPlayer"
                let courtNum = "1"

                resViewModel.makeRes(id: id, player: player, courtNum: courtNum)
                
                
                var resViewModel: ResViewModel!
                var mockFirestore: MockFirestore! // Create a mock for Firestore
                
                func setUp() {
                    super.setUp()
                    mockFirestore = MockFirestore() // Initialize your mock Firestore
                    resViewModel = ResViewModel()
                    //resViewModel.db = mockFirestore // Inject the mock Firestore
                    // Set up any initial conditions if needed
                }
                
                func tearDown() {
                    // Clean up after each test if needed
                    mockFirestore = nil
                    resViewModel = nil
                    super.tearDown()
                }
                

                // Simulate a delay to allow Firestore to complete the operation (adjust the time as needed)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    // Assuming the completion block or some flag in your mock or testing double signals the completion of Firestore operation
                    // Assert that Firestore updateData was called
                    XCTAssertTrue(mockFirestore.didUpdateData)
                    // Assert specific details like the document ID, updated data, etc.
                    XCTAssertEqual(mockFirestore.updatedDocumentID, id)
                    XCTAssertEqual(mockFirestore.updatedData["reserved"] as? Bool, true)
                    XCTAssertEqual(mockFirestore.updatedData["player"] as? String, player)

                    expectation.fulfill()
                }

                waitForExpectations(timeout: 5) // Adjust the timeout as per your needs
            }

        }
        
        func testFetchRes() {
            let courtNumber = "1" // Set the court number for testing
            
            let expectation = XCTestExpectation(description: "Fetch reservations")
            
            resViewModel.fetchRes(courtNum: courtNumber)
            
            // Simulating an asynchronous call to wait for Firestore response
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                // Assuming Firestore call would take at least 5 seconds, adjust the time as per your needs
                XCTAssertFalse(self.resViewModel.reservations.isEmpty)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 10) // Adjust the timeout as per your needs
        }
        
        // Add similar XCTest methods for other functions like `makeRes`, `deleteRes`, `createRes`, etc.



//            func testDeleteRes() {
//                // Initial setup or necessary data loading
//
//                // Add some reservation to be deleted
//                let testReservation = Reservation(id: "testID", day: "2023-12-01 08:00:00", month: "Test Player", year: true, start: "1:00pm", end: "2:00pm")
//                resViewModel.reservations = [testReservation]
//
//                let initialReservationsCount = resViewModel.reservations.count
//
//                // Attempt to delete the reservation
//                resViewModel.deleteRes(id: "testID", courtNum: "1")
//
//                // After deletion, verify that the reservation was removed
//                let remainingReservationsCount = resViewModel.reservations.count
//
//                XCTAssertEqual(remainingReservationsCount, initialReservationsCount - 1)
//            }
        
            func testMakeRes() {
                // Initial setup or necessary data loading

                let initialReservationsCount = resViewModel.reservations.count

                // Create a reservation
                resViewModel.makeRes(id: "testID", player: "Test Player", courtNum: "1")

                // After making the reservation, verify that the count has increased by one
                let updatedReservationsCount = resViewModel.reservations.count

                XCTAssertEqual(updatedReservationsCount, initialReservationsCount + 1)
            }
        
        
        func testMakeResValidity() {
            // Initial setup

            let player = "Test Player"
            let courtNum = "1"
            let id = "testID"

            resViewModel.makeRes(id: id, player: player, courtNum: courtNum)

            // Retrieve the last added reservation
            guard let newReservation = resViewModel.reservations.last else {
                XCTFail("Reservation not added")
                return
            }

            XCTAssertEqual(newReservation.player, player)
            //XCTAssertEqual(newReservation.courtNum, courtNum)
            XCTAssertEqual(newReservation.id, id)
            // Add assertions for other attributes you expect in a new reservation
        }
        
        func testUserReservationListUpdated() {
            let player = "User123"
            let courtNum = "2"
            let id = "testID2"

            // Assuming the initial user's reservations count is known
            let initialUserReservationsCount = resViewModel.reservations.filter { $0.player == player }.count

            resViewModel.makeRes(id: id, player: player, courtNum: courtNum)

            let updatedUserReservationsCount = resViewModel.reservations.filter { $0.player == player }.count

            XCTAssertEqual(updatedUserReservationsCount, initialUserReservationsCount + 1)
        }

        func testAddingReservations() {
            let initialReservationsCount = resViewModel.reservations.count

            resViewModel.makeRes(id: "uniqueID", player: "Test Player", courtNum: "3")

            XCTAssertEqual(resViewModel.reservations.count, initialReservationsCount + 1)
        }

        func testAddedReservationExists() {
            let id = "uniqueID"
            resViewModel.makeRes(id: id, player: "Tester", courtNum: "2")

            guard let addedReservation = resViewModel.reservations.first(where: { $0.id == id }) else {
                XCTFail("Reservation with ID \(id) was not added")
                return
            }
            
            XCTAssertEqual(addedReservation.player, "Tester")
            //XCTAssertEqual(addedReservation.courtNum, "2")
            // Add assertions for other attributes
        }

//        func testReservationsState() {
//
//            resViewModel.makeRes(id: "uniqueID2", player: "Tester", courtNum: "4")
//
//            let newReservations = resViewModel.reservations.filter { $0.player == "Tester" }
//            let reservedCourts = Set(newReservations.map { $0.courtNum })
//
//            XCTAssertTrue(reservedCourts.contains("Tester"))
//            // Add more assertions based on your reservation state logic
//        }


        

    }

class ResViewModelTests2: XCTestCase {
    var resViewModel: ResViewModel!

    override func setUp() {
        super.setUp()
        resViewModel = ResViewModel()
    }

    override func tearDown() {
        resViewModel = nil
        super.tearDown()
    }

    func testDeleteRes_WithValidID() {
        // Given
        let idToDelete = "1234" // Example ID
        let courtNumber = "2" // Example Court Number

        // When
        resViewModel.deleteRes(id: idToDelete, courtNum: courtNumber)

        // Then
        // Add assertions to check the result of the deletion or changes made.
        // For instance, check a specific state, array modification, or any side effects.
        // XCTAssertEqual or XCTAssertTrue can be used to check these effects.
    }

    func testDeleteRes_WithInvalidID() {
        // Given
        let idToDelete = "9999" // Assuming this ID doesn't exist
        let courtNumber = "3"

        // When
        resViewModel.deleteRes(id: idToDelete, courtNum: courtNumber)

        // Then
        // Validate that with an invalid ID, the method handles it appropriately.
        // For example, by not making any changes or returning an error state.
        // Use XCTAssertNil or similar assertions to verify the behavior.
    }
}

class MatchesListViewTests: XCTestCase {
    
    // Mock data for testing
    let testMatches: [Match] = [
        Match(userID: "1", name: "John", skillLevel: "Beginner", gender: "Male", type: "Singles", time: [0, 1, 0, 0, 1,0,0,0,0,0,0,0,0,0,0]),
        Match(userID: "2", name: "Jane", skillLevel: "Club", gender: "Female", type: "Doubles", time: [1, 0, 1, 0, 1,0,0,0,0,0,0,0,0,0,0]),
        Match(userID: "3", name: "Alex", skillLevel: "College", gender: "Non-Binary", type: "Singles", time: [1, 1, 0, 1,0,0,0,0,0,0,0,0,0,0,0])
    ]
    
    func testFetchData() {
        XCTAssertEqual(testMatches, [
            Match(userID: "1", name: "John", skillLevel: "Beginner", gender: "Male", type: "Singles", time: [0, 1, 0, 0, 1,0,0,0,0,0,0,0,0,0,0]),
            Match(userID: "2", name: "Jane", skillLevel: "Club", gender: "Female", type: "Doubles", time: [1, 0, 1, 0, 1,0,0,0,0,0,0,0,0,0,0]),
            Match(userID: "3", name: "Alex", skillLevel: "College", gender: "Non-Binary", type: "Singles", time: [1, 1, 0, 1,0,0,0,0,0,0,0,0,0,0,0])
        ], "Match Equality Operator not working as expected")
        
        let matchesViewModel = MatchesViewModel()
        var explicitVariable: Match?
        
        
        matchesViewModel.fetchData()
        //var explicitVariable: Match = matchesViewModel.fetchData(completion: ([Match]) -> Void)
        // Fetch reservations for court 1
        //let match1 = matchesViewModel.fetchData()
        //print("!!!!!!!!!!!!!!!!!!!!!!!!!!!\(match1.name)")
                        // After fetch, the reservations array should not be empty
        //XCTAssertFalse(matchesViewModel.users.isEmpty)
    }
    
    func testFilterMatches() {
        let expectation = XCTestExpectation(description: "Filter matches based on criteria")
        
        Task {
            do {
                let matchesViewModel = MatchesViewModel()
                matchesViewModel.matches = testMatches
                //Test Automatic Filtering
                //Automatic Time Availability Filtering
                var currUser = "CurrentUser"
                var currUserTime = [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0]
                var filteredMatches = matchesViewModel.matches
                filteredMatches = matchesViewModel.matches.filter { match in
                    matchesViewModel.filterMatches(match: match, sendFilter: Match(userID: "", name: "", skillLevel: "", gender: "", type: "", time: []), currUser: "", currTime: currUserTime)
                }
                XCTAssertEqual(filteredMatches.count, 2, "Filtering by availibility did not work as expected")
                
                currUserTime = [1,1,0,0,0,0,0,0,0,0,0,0,0,0,0]
                filteredMatches = matchesViewModel.matches
                filteredMatches = matchesViewModel.matches.filter { match in
                    matchesViewModel.filterMatches(match: match, sendFilter: Match(userID: "", name: "", skillLevel: "", gender: "", type: "", time: []), currUser: "", currTime: currUserTime)
                }
                XCTAssertEqual(filteredMatches.count, 3, "Filtering by availibility did not work as expected")
                
                currUserTime = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
                filteredMatches = matchesViewModel.matches
                filteredMatches = matchesViewModel.matches.filter { match in
                    matchesViewModel.filterMatches(match: match, sendFilter: Match(userID: "", name: "", skillLevel: "", gender: "", type: "", time: []), currUser: "", currTime: currUserTime)
                }
                XCTAssertEqual(filteredMatches.count, 0, "Filtering by availibility did not work as expected")
                
                
                //Automatic Personal Account Filtering
                currUser = "Jane"
                currUserTime = [1,1,0,0,0,0,0,0,0,0,0,0,0,0,0]
                filteredMatches = matchesViewModel.matches
                filteredMatches = matchesViewModel.matches.filter { match in
                    matchesViewModel.filterMatches(match: match, sendFilter: Match(userID: "", name: currUser, skillLevel: "", gender: "", type: "", time: []), currUser: currUser, currTime: currUserTime)
                }
                XCTAssertEqual(filteredMatches.count, 2, "Filtering by personal name did not work as expected")
                
                // Test filtering by skill level
                filteredMatches = matchesViewModel.matches.filter { match in
                    matchesViewModel.filterMatches(match: match, sendFilter: Match(userID: "", name: "", skillLevel: "Club", gender: "", type: "", time: []), currUser: "", currTime: [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1])
                }
                print("Filtered matches: \(filteredMatches)")
                XCTAssertEqual(filteredMatches.count, 1, "Filtering matches by skill level did not work as expected")
                XCTAssertEqual(filteredMatches.first?.name, "Jane", "Filtered match has unexpected name")
                
                // Test filtering by gender
                filteredMatches = matchesViewModel.matches.filter { match in
                    matchesViewModel.filterMatches(match: match, sendFilter: Match(userID: "", name: "", skillLevel: "", gender: "Female", type: "", time: []), currUser: "", currTime: [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1])
                }
                XCTAssertEqual(filteredMatches.count, 1, "Filtering matches by gender did not work as expected")
                XCTAssertEqual(filteredMatches.first?.name, "Jane", "Filtered match has unexpected name")
                
                // Test filtering by play type
                filteredMatches = matchesViewModel.matches.filter { match in
                    matchesViewModel.filterMatches(match: match, sendFilter: Match(userID: "", name: "", skillLevel: "", gender: "", type: "Singles", time: []), currUser: "", currTime: [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1])
                }
                XCTAssertEqual(filteredMatches.count, 2, "Filtering matches by play type did not work as expected")
                
                expectation.fulfill()
            } catch {
                XCTFail("Failed to filter matches: \(error.localizedDescription)")
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
