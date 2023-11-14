import XCTest
import FirebaseFirestore
@testable import SWEGroup12_Tennis // Import your app module

class MatchesListViewTests: XCTestCase {
        var viewModel: MatchesViewModel!

        override func setUp() {
            super.setUp()
            viewModel = MatchesViewModel()
        }

        override func tearDown() {
            viewModel = nil
            super.tearDown()
        }

        func testFetchData() {
            // Create a mock Firestore document
            let mockDocument: [String: Any] = [
                "id": "mockUserID",
                "name": "Mock User",
                "skillLevel": "Intermediate",
                "gender": "Male",
                "type": "Singles",
                "datesSelected": [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            ]

            // Create a mock QuerySnapshot with the mock document
            let mockQuerySnapshot = MockQuerySnapshot(documents: [MockQueryDocumentSnapshot(data: mockDocument)])

            // Replace the fetchData Firestore call with our mock
            viewModel.db = MockFirestore(mockQuerySnapshot)
            //internal func setFirestore(_ firestore: Firestore) {
            //    self.db = firestore
            //}
            // Call the function to fetch data
            viewModel.fetchData()

            // Wait for a short time to allow the async operation to complete
            let expectation = XCTestExpectation(description: "Wait for fetchData() to complete")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5)

            // Assert that matches array is not empty
            XCTAssertFalse(viewModel.matches.isEmpty, "Matches array should not be empty")
            
            // Add more assertions as needed based on your data and logic
        }
    }

    // Mock classes for Firestore
    class MockFirestore: Firestore {
        let mockQuerySnapshot: QuerySnapshot

        init(_ mockQuerySnapshot: QuerySnapshot) {
            self.mockQuerySnapshot = mockQuerySnapshot
            super.init()
        }

        override func collection(_ collectionPath: String) -> CollectionReference {
            let mockCollectionReference = MockCollectionReference(collectionPath)
            mockCollectionReference.mockQuerySnapshot = mockQuerySnapshot
            return mockCollectionReference
        }
    }

    class MockCollectionReference: CollectionReference {
        var mockQuerySnapshot: QuerySnapshot?

        override func addSnapshotListener(_ listener: @escaping FIRQuerySnapshotBlock) -> ListenerRegistration {
            listener(mockQuerySnapshot, nil)
            return MockListenerRegistration()
        }
    }

    class MockListenerRegistration: ListenerRegistration {
        // Mock implementation
    }

    // Mock classes for Firestore
    class MockQuerySnapshot: QuerySnapshot {
        let documents: [MockQueryDocumentSnapshot]

        init(documents: [MockQueryDocumentSnapshot]) {
            self.documents = documents
        }

        override var count: Int {
            return documents.count
        }

        override func documentChanges(includesMetadataChanges: Bool) -> [DocumentChange] {
            // Mock implementation
            return []
        }

        override func document(at index: Int) -> QueryDocumentSnapshot {
            return documents[index]
        }
    }

    class MockQueryDocumentSnapshot: QueryDocumentSnapshot {
        let data: [String: Any]

        init(data: [String: Any]) {
            self.data = data
        }

        override var exists: Bool {
            return true
        }

        override func get(_ fieldPath: FIRFieldPathType) -> Any? {
            return data[fieldPath as! String]
        }

        override func data() -> [String: Any] {
            return data
        }
    
    // Mock data for testing
    let testMatches: [Match] = [
        Match(userID: "1", name: "John", skillLevel: "Beginner", gender: "Male", type: "Singles", time: [0, 1, 0, 0, 1,0,0,0,0,0,0,0,0,0,0]),
        Match(userID: "2", name: "Jane", skillLevel: "Club", gender: "Female", type: "Doubles", time: [1, 0, 1, 0, 1,0,0,0,0,0,0,0,0,0,0]),
        Match(userID: "3", name: "Alex", skillLevel: "College", gender: "Non-Binary", type: "Singles", time: [1, 1, 0, 1,0,0,0,0,0,0,0,0,0,0,0])
    ]
    
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
   
   // Add more test cases as needed...
}
