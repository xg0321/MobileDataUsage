//
//  QuarterDataModelTests.swift
//  SPHDemoTests
//
//  Created by admin on 2020/4/5.
//  Copyright © 2020 admin. All rights reserved.
//

import XCTest
@testable import SPHDemo

class QuarterDataModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testJsonIsNil() {
        let model = QuarterDataModel(from: nil)
        XCTAssert(model.quarterInt == 0)
        XCTAssert(model.volumeOfMobileData == 0)
    }
    
    func testInvalidYear() {
        let json = JSON(["quarter" : "abcd-Q3", "volume_of_mobile_data" : "12.35"])
        let model = QuarterDataModel(from: json)
        XCTAssert(model.quarterInt == 0)
        XCTAssert(model.volumeOfMobileData == 0)
    }
    
    func testInvalidQuarter() {
        let json = JSON(["quarter" : "2018-Qa", "volume_of_mobile_data" : "12.35"])
        let model = QuarterDataModel(from: json)
        XCTAssert(model.quarterInt == 0)
        XCTAssert(model.volumeOfMobileData == 0)
    }
    
    func testValidQuarter() {
        let json = JSON(["quarter" : "2018-Q3", "volume_of_mobile_data" : "12.35"])
        let model = QuarterDataModel(from: json)
        XCTAssert(model.quarterInt == 20183)
        XCTAssert(model.volumeOfMobileData == 12.35)
    }

}
