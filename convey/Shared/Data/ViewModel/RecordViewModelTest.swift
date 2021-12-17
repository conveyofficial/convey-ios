//
//  RecordViewModelTest.swift
//  convey (iOS)
//
//  Created by Grant Jensen on 11/19/21.
//

import XCTest
@testable import convey


class RecordViewModelTest: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func NonNegativeTime() throws {
        let RecordViewModel = RecordViewModel(firestoreService: AppModule.passFirestoreService(), authService: AppModule.passAuthService())
        XCTAssertGreaterThanOrEqual(RecordViewModel.time, 0,"Must always have non-negative time")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
