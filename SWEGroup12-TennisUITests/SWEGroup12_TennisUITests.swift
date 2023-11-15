import XCTest

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
