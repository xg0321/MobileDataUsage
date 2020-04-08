//
//  NetworkTests.swift
//  SPHDemoTests
//
//  Created by admin on 2020/4/5.
//  Copyright © 2020 admin. All rights reserved.
//

import XCTest
@testable import SPHDemo
import OHHTTPStubs

class NetworkTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRequestSuccessful() {
        OHHTTPStubs.stubRequests(passingTest: { (request) -> Bool in
            return request.url?.host == "data.gov.sg"
        }) { (request) -> OHHTTPStubsResponse in
            let stubPath = OHPathForFile("MockData.json", type(of: self))
            return fixture(filePath: stubPath!, status: 200, headers: ["Content-Type":"application/json"])
        }
        
        let url = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
        let expectation = self.expectation(description: "请求成功，HTTP响应码200")
        HttpHelper.shared.get(url) { (errorInfo, json) in
            if json != nil {
                print("json: \(json!)")
                expectation.fulfill()
            } else {
                print("错误信息: \(errorInfo)")
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 30, handler: nil)
        
    }
    
    func testRequestFailureWithError500() {
        OHHTTPStubs.stubRequests(passingTest: { (request) -> Bool in
            return request.url?.host == "data.gov.sg"
        }) { (request) -> OHHTTPStubsResponse in
            let error : NSError = NSError.init(domain: NSURLErrorDomain, code: 500, userInfo: ["describe":"Internal Server Error"])
            return OHHTTPStubsResponse.init(error: error)
        }
        
        let url = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
        let expectation = self.expectation(description: "请求失败，HTTP响应码500")
        HttpHelper.shared.get(url) { (errorInfo, json) in
            if json != nil {
                print("json: \(json!)")
                XCTFail()
            } else {
                print("错误信息: \(errorInfo)")
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testRequestFailureWithError404() {
        OHHTTPStubs.stubRequests(passingTest: { (request) -> Bool in
            return request.url?.host == "data.gov.sg"
        }) { (request) -> OHHTTPStubsResponse in
            let error : NSError = NSError.init(domain: NSURLErrorDomain, code: 404, userInfo: ["describe":"Not Found"])
            return OHHTTPStubsResponse.init(error: error)
        }
        
        let url = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
        let expectation = self.expectation(description: "请求失败，HTTP响应码404")
        HttpHelper.shared.get(url) { (errorInfo, json) in
            if json != nil {
                print("json: \(json!)")
                XCTFail()
            } else {
                print("错误信息: \(errorInfo)")
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
}
