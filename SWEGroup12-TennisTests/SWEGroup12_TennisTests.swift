//
//  SWEGroup12_TennisTests.swift
//  SWEGroup12-TennisTests
//
//  Created by Sydney Leonardi on 9/27/23.
//

import XCTest

final class SWEGroup12_TennisTests: XCTestCase {
    func testNavigationBetweenMatchesListViewAndFilterView() {
        let app = XCUIApplication()
        app.launch()
        
        // Verify that the initial screen contains a button to navigate to MatchesListView
        let goToMatchesListViewButton = app.buttons["Go to MatchesListView"]
        XCTAssertTrue(goToMatchesListViewButton.exists)
        
        // Tap the button to navigate to MatchesListView
        goToMatchesListViewButton.tap()
        
        // Verify that MatchesListView is displayed
        let potentialMatchesTitle = app.staticTexts["Potential Matches"]
        XCTAssertTrue(potentialMatchesTitle.exists)
        
        // Navigate to FilterView from MatchesListView
        app.buttons["Advanced Filter"].tap()
        
        // Verify that FilterView is now displayed
        let filterForMatchTitle = app.staticTexts["**Filter For Match**"]
        XCTAssertTrue(filterForMatchTitle.exists)
        
        // Navigate back to MatchesListView
        app.navigationBars.buttons["Potential Matches"].tap()
        
        // Verify that MatchesListView is displayed again
        XCTAssertTrue(potentialMatchesTitle.exists)
        
        
    }
    func testGenderFilteringFromFilterViewToMatchesListView() {
        let app = XCUIApplication()
        app.launch()

        // Navigate to FilterView from the main screen
        app.buttons["Go to FilterView"].tap()

        // Verify that FilterView is displayed
        let filterForMatchTitle = app.staticTexts["**Filter For Match**"]
        XCTAssertTrue(filterForMatchTitle.exists)

        // Apply the gender filter (e.g., select "Female")
        app.buttons["Female"].tap()

        // Tap the "Apply Filter" button to navigate to MatchesListView
        app.buttons["Apply Filter"].tap()

        // Verify that MatchesListView is now displayed
        let potentialMatchesTitle = app.staticTexts["Potential Matches"]
        XCTAssertTrue(potentialMatchesTitle.exists)

        // Verify that the gender filter is applied by checking that all displayed items match the filter
        //checking female filter works
        for cell in app.cells.allElementsBoundByIndex {
            let genderLabel = cell.staticTexts.matching(identifier: "GenderLabel").firstMatch

            // Verify that the gender label in each cell matches the selected gender filter
            let genderLabelText = genderLabel.label
            XCTAssertTrue(genderLabelText.contains("Gender: Female"))
        }
    }
}

