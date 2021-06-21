//
//  ChoresTests.swift
//  ChoresTests
//
//  Created by 黃瀞萱 on 2021/6/19.
//

import XCTest
@testable import Chores

class ChoresTests: XCTestCase {
    
    var sut: SpendPointsViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        try super.setUpWithError()
        sut = SpendPointsViewController()

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
        try super.tearDownWithError()
    }
    
    func testPointsIsdeductedSuccess() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // given
        var user: User = User(id: "1", name: "1", picture: "1", points: 301, weekHours: 44, totalHours: 44, groupId: "1", isSpent: false)
        
        // when
        let result = sut.deductPoints(user: &user)
        
        // then
        XCTAssertEqual(result, true, "your points is enough")
    }
    
    func testPointsIsdeductedError() {
        
        // given
        var user: User = User(id: "2", name: "2", picture: "2", points: 299, weekHours: 33, totalHours: 33, groupId: "2", isSpent: false)
        
        // when
        let result = sut.deductPoints(user: &user)
        
        // then
        XCTAssertEqual(result, false, "your points is not enough")
    }
    
//    func testScoreIsComputedPerformance() {
//      measure(metrics: [XCTClockMetric(), XCTCPUMetric(), XCTStorageMetric(), XCTMemoryMetric()]) {
//        sut.spendUserPoints()
//      }
//    }
    
}
