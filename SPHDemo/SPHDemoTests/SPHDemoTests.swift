//
//  SPHDemoTests.swift
//  SPHDemoTests
//
//  Created by admin on 2020/4/4.
//  Copyright © 2020 admin. All rights reserved.
//

import XCTest
@testable import SPHDemo

class SPHDemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.cornerRadius = 10
        view.borderWidth = 1
        view.borderColor = .red
        XCTAssert(view.cornerRadius == 10)
        XCTAssert(view.borderWidth == 1)
        XCTAssert(view.borderColor == UIColor.red)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
