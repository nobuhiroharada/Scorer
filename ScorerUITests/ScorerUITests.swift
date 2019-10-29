//
//  ScorerUITests.swift
//  ScorerUITests
//
//  Created by Nobuhiro Harada on 2019/10/26.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import XCTest

class ScorerUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        self.app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        self.testCommonLabel(id: "teamLabelA", text: "HOME")
        self.testCommonLabel(id: "teamLabelB", text: "GUEST")
        self.testCommonLabel(id: "scoreLabelA", text: "00")
        self.testCommonLabel(id: "scoreLabelB", text: "00")
        
        self.testCommonButton(id: "scoreMinusButtonA", imageName: "down-button")
        self.testCommonButton(id: "scorePlusButtonA", imageName: "up-button")
        self.testCommonButton(id: "scoreMinusButtonB", imageName: "down-button")
        self.testCommonButton(id: "scorePlusButtonB", imageName: "up-button")
        
        self.testCommonButton(id: "buzzerButton", imageName: "buzzer-up")
        
        self.testCommonButton(id: "settingButton", imageName: "setting")
        
        self.testCommonImage(id: "possessionImageA", imageName: "posses-a-active")
        self.testCommonImage(id: "possessionImageB", imageName: "posses-b-inactive")
        
        self.testCommonImage(id: "foulCountImageA1", imageName: "foulcount-inactive")
        self.testCommonImage(id: "foulCountImageA2", imageName: "foulcount-inactive")
        self.testCommonImage(id: "foulCountImageA3", imageName: "foulcount-inactive")
        self.testCommonImage(id: "foulCountImageA4", imageName: "foulcount-inactive")
        self.testCommonImage(id: "foulCountImageA5", imageName: "foulcount-inactive")
        
        self.testCommonImage(id: "foulCountImageB1", imageName: "foulcount-inactive")
        self.testCommonImage(id: "foulCountImageB2", imageName: "foulcount-inactive")
        self.testCommonImage(id: "foulCountImageB3", imageName: "foulcount-inactive")
        self.testCommonImage(id: "foulCountImageB4", imageName: "foulcount-inactive")
        self.testCommonImage(id: "foulCountImageB5", imageName: "foulcount-inactive")
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testCommonLabel(id: String, text: String) {
        let label = XCUIApplication().buttons[id]
        XCTAssert(label.isEnabled)
        XCTAssert(label.isHittable)
        XCTAssertEqual(label.label, text)
    }
    
    func testCommonButton(id: String, imageName: String) {
        let button = XCUIApplication().buttons[id]
        XCTAssert(button.isEnabled)
        XCTAssert(button.isHittable)
//        XCTAssertTrue(app.images[imageName].exists)
    }
    
    func testCommonImage(id: String, imageName: String) {
        let image = XCUIApplication().buttons[id]
//        XCTAssert(image.isEnabled)
//        XCTAssert(image.isHittable)
//        XCTAssertTrue(app.images[imageName].exists)
    }
    
    func testTeamNameLabel(id: String, text: String) {
        
    }
    
}
