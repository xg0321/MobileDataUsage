//
//  NetworkTests.swift
//  SPHDemoTests
//
//  Created by admin on 2020/4/5.
//  Copyright © 2020 admin. All rights reserved.
//

import XCTest
@testable import SPHDemo

class NetworkTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRequestSuccessful() {
        let url = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
        let expectation = self.expectation(description: "请求成功")
        HttpHelper.shared.get(url) { (errorInfo, json) in
            if json != nil {
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testRequestFailure() {
        let url = "https://data.gov.sg/api/action/datastore_search"
        let expectation = self.expectation(description: "请求失败")
        HttpHelper.shared.get(url) { (errorInfo, json) in
            if json != nil {
                XCTFail()
            } else {
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
