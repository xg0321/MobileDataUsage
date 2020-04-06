//
//  SPHDemoUITests.swift
//  SPHDemoUITests
//
//  Created by admin on 2020/4/4.
//  Copyright © 2020 admin. All rights reserved.
//

import XCTest

class SPHDemoUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        
        let tabelExist = app.tables.element(boundBy: 0).waitForExistence(timeout: 30)
        
        if tabelExist {
            let tablesQuery = app.tables
            tablesQuery.cells.containing(.staticText, identifier:"2011年").buttons["提示"].tap()
            app.alerts["2011年第2季度数据量下降"].buttons["知道了"].tap()
            
            let tablesQuery2 = tablesQuery
            tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["2011年"]/*[[".cells.staticTexts[\"2011年\"]",".staticTexts[\"2011年\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
            tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"2013年")/*[[".cells.containing(.staticText, identifier:\"28.496852 PB\")",".cells.containing(.staticText, identifier:\"2013年\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["提示"].tap()
            app.alerts["2013年第1、4季度数据量下降"].buttons["知道了"].tap()
            tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["28.496852 PB"]/*[[".cells.staticTexts[\"28.496852 PB\"]",".staticTexts[\"28.496852 PB\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
            tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"2015年")/*[[".cells.containing(.staticText, identifier:\"41.253493 PB\")",".cells.containing(.staticText, identifier:\"2015年\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["提示"].tap()
            app.alerts["2015年第4季度数据量下降"].buttons["知道了"].tap()
            tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["41.253493 PB"]/*[[".cells.staticTexts[\"41.253493 PB\"]",".staticTexts[\"41.253493 PB\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        } else {
            app.buttons["刷新"].tap()
        }
    }

}
