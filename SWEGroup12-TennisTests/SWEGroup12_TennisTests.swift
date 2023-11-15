import XCTest
import FirebaseFirestore
import SwiftUI
@testable import SWEGroup12_Tennis

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
        //var explicitVariable: Match = matchesViewModel.fetchData(completion: <#([Match]) -> Void#>)
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
