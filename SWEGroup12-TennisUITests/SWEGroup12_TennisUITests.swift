//
//  SWEGroup12_TennisUITests.swift
//  SWEGroup12-TennisUITests
//
//  Created by Sydney Leonardi on 9/27/23.
//

import XCTest

final class SWEGroup12_TennisUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

class MatchesListViewUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testShowFiltersButton() {
        // Check if the "Show Filters" button exists
        let showFiltersButton = app.buttons["Show Filters"]
        XCTAssertTrue(showFiltersButton.exists)
        
        // Tap the "Show Filters" button
        showFiltersButton.tap()
        
        // Check if the filter options view is displayed
        let filterOptionsView = app.otherElements["FilterOptionsMenuView"]
        XCTAssertTrue(filterOptionsView.exists)
    }

    func testTapRowInList() {
        // Assuming there's at least one row in the list
        let firstRow = app.tables.cells.firstMatch
        XCTAssertTrue(firstRow.exists)
        
        // Tap the first row
        firstRow.tap()
        
        // Check if the destination view is displayed
        let otherProfileView = app.otherElements["OtherProfileView"]
        XCTAssertTrue(otherProfileView.exists)
    }
    
        
        
        // Check if the filter options view is displayed
        //let filterOptionsView = app.otherElements["FilterOptionsMenuView"]
        //XCTAssertTrue(filterOptionsView.exists)
    

    // Add more test cases as needed

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
}
    
class LogInViewUITests: XCTestCase {

        let app = XCUIApplication()

        override func setUp() {
            continueAfterFailure = false
            app.launch()
        }

        func testSuccessfulLogin() {
            // UI test for successful login with valid credentials
            app.textFields["Vanderbilt Email"].tap()
            app.textFields["Vanderbilt Email"].typeText("valid_email@example.com")
            
            app.secureTextFields["Password"].tap()
            app.secureTextFields["Password"].typeText("validpassword")

            app.buttons["Sign in"].tap()
            
            // Verify that the user is successfully logged in (e.g., navigate to the next screen)
            // Add appropriate UI test assertions here
        }

        func testIncorrectEmailFormat() {
            // UI test for entering an incorrect email format
            app.textFields["Email"].tap()
            app.textFields["Email"].typeText("invalid_email")

            app.secureTextFields["Password"].tap()
            app.secureTextFields["Password"].typeText("validpassword")

            app.buttons["Sign in"].tap()
            
            // Verify that an error message is displayed for an invalid email format
            // Add appropriate UI test assertions here
        }

        func testShortPassword() {
            // UI test for entering a short password
            app.textFields["Email"].tap()
            app.textFields["Email"].typeText("valid_email@example.com")

            app.secureTextFields["Password"].tap()
            app.secureTextFields["Password"].typeText("short")

            app.buttons["Sign in"].tap()
            
            // Verify that an error message is displayed for a short password
            // Add appropriate UI test assertions here
        }

        func testUnverifiedAccount() {
            // UI test for trying to log in with an unverified account
            app.textFields["Email"].tap()
            app.textFields["Email"].typeText("valid_email@example.com")

            app.secureTextFields["Password"].tap()
            app.secureTextFields["Password"].typeText("validpassword")

            app.buttons["Sign in"].tap()
            
            // Verify that an error message is displayed for an unverified account
            // Add appropriate UI test assertions here
        }

        func testEmptyEmailAndPassword() {
            // UI test for trying to log in with empty email and password fields
            app.buttons["Sign in"].tap()
            
            // Verify that an error message is displayed for empty fields
            // Add appropriate UI test assertions here
        }
    }
    
    class CalendarResViewTests2: XCTestCase {
        var app: XCUIApplication!

        override func setUp() {
            continueAfterFailure = false
            app = XCUIApplication()
            app.launch()
        }

        func testViewInitialState() {
            let calendarLabel = app.staticTexts["Calendar"]
            XCTAssertTrue(calendarLabel.exists)

            let defaultSelectedDate = app.datePickers["Select Date"]
            XCTAssertTrue(defaultSelectedDate.exists)

            let court1Button = app.buttons["Court 1"]
            XCTAssertTrue(court1Button.exists)
        }

        func testNavigateToResTimeView() {
            let court1Button = app.buttons["Court 1"]
            court1Button.tap()

            // Simulate interactions and assert expected elements in ResTimeView
            let confirmationButton = app.buttons["Confirm Reservation"]
            XCTAssertTrue(confirmationButton.exists)
        }

        func testNavigateToDeleteResView() {
            let court1Button = app.buttons["Court 1"]
            court1Button.tap()

            // Navigate to DeleteResView
            let confirmationButton = app.buttons["Confirm Reservation"]
            confirmationButton.tap()

            // Simulate interactions and assert expected elements in DeleteResView
            let deleteButton = app.buttons["Delete Reservation"]
            XCTAssertTrue(deleteButton.exists)
        }
    }
    
    class SignUpViewTests: XCTestCase {

        let app = XCUIApplication()

        override func setUp() {
            continueAfterFailure = false
            app.launch()
            app.buttons["Sign up"].tap()
        }

        func testSuccessfulSignUp() {
            // UI test for successful signup with valid credentials
            app.textFields["Vanderbilt Email"].tap()
            app.textFields["Vanderbilt Email"].typeText("valid_email@vanderbilt.edu")

            app.secureTextFields["Password"].tap()
            app.secureTextFields["Password"].typeText("validpassword")

            app.secureTextFields["Confirm Password"].tap()
            app.secureTextFields["Confirm Password"].typeText("validpassword")

            app.buttons["Sign Up"].tap()

            // Verify that the user is successfully signed up (e.g., navigate to the next screen)
            // Add appropriate UI test assertions here
        }

        func testEmailAlreadyInUse() {
            // UI test for trying to sign up with an email that is already in use
            app.textFields["Vanderbilt Email"].tap()
            app.textFields["Vanderbilt Email"].typeText("used_email@vanderbilt.edu")

            app.secureTextFields["Password"].tap()
            app.secureTextFields["Password"].typeText("validpassword")

            app.secureTextFields["Confirm Password"].tap()
            app.secureTextFields["Confirm Password"].typeText("validpassword")

            app.buttons["Sign Up"].tap()

            // Verify that an error message is displayed for an email already in use
            // Add appropriate UI test assertions here
        }

        func testNetworkError() {
            // UI test for encountering a network error during signup
            app.textFields["Vanderbilt Email"].tap()
            app.textFields["Vanderbilt Email"].typeText("valid_email@vanderbilt.edu")

            app.secureTextFields["Password"].tap()
            app.secureTextFields["Password"].typeText("validpassword")

            app.secureTextFields["Confirm Password"].tap()
            app.secureTextFields["Confirm Password"].typeText("validpassword")

            app.buttons["Sign Up"].tap()

            // Verify that an error message is displayed for a network error
            // Add appropriate UI test assertions here
        }

        func testPasswordMismatch() {
            // UI test for trying to sign up with mismatched passwords
            app.textFields["Vanderbilt Email"].tap()
            app.textFields["Vanderbilt Email"].typeText("valid_email@vanderbilt.edu")

            app.secureTextFields["Password"].tap()
            app.secureTextFields["Password"].typeText("validpassword")

            app.secureTextFields["Confirm Password"].tap()
            app.secureTextFields["Confirm Password"].typeText("mismatchedpassword")

            app.buttons["Sign Up"].tap()

            // Verify that an error message is displayed for password mismatch
            // Add appropriate UI test assertions here
        }

        func testInvalidVanderbiltEmail() {
            // UI test for trying to sign up with an invalid Vanderbilt email
            app.textFields["Vanderbilt Email"].tap()
            app.textFields["Vanderbilt Email"].typeText("invalidemail")

            app.secureTextFields["Password"].tap()
            app.secureTextFields["Password"].typeText("validpassword")

            app.secureTextFields["Confirm Password"].tap()
            app.secureTextFields["Confirm Password"].typeText("validpassword")

            app.buttons["Sign Up"].tap()

            // Verify that an error message is displayed for an invalid email format
            // Add appropriate UI test assertions here
        }

        func testShortPassword() {
            // UI test for trying to sign up with a short password
            app.textFields["Vanderbilt Email"].tap()
            app.textFields["Vanderbilt Email"].typeText("valid_email@vanderbilt.edu")

            app.secureTextFields["Password"].tap()
            app.secureTextFields["Password"].typeText("short")

            app.secureTextFields["Confirm Password"].tap()
            app.secureTextFields["Confirm Password"].typeText("short")

            app.buttons["Sign Up"].tap()

            // Verify that an error message is displayed for a short password
            // Add appropriate UI test assertions here
        }

        func testEmptyFields() {
            // UI test for trying to sign up with empty email and password fields
            app.buttons["Sign Up"].tap()

            // Verify that an error message is displayed for empty fields
            // Add appropriate UI test assertions here
        }
    }
