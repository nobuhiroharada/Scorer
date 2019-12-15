//
//  ScorerUITests.swift
//  ScorerUITests
//
//  Created by Nobuhiro Harada on 2019/10/26.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import XCTest
@testable import Scorer

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

    func testInitView() {
        
        self.setCommonLabel(id: "teamLabelA", text: "HOME")
        self.setCommonLabel(id: "teamLabelB", text: "GUEST")
        self.setCommonLabel(id: "scoreLabelA", text: "00")
        self.setCommonLabel(id: "scoreLabelB", text: "00")
        
        self.setCommonButton(id: "scoreMinusButtonA", imageName: "down-button")
        self.setCommonButton(id: "scorePlusButtonA", imageName: "up-button")
        self.setCommonButton(id: "scoreMinusButtonB", imageName: "down-button")
        self.setCommonButton(id: "scorePlusButtonB", imageName: "up-button")
        
        self.setCommonButton(id: "buzzerButton", imageName: "buzzer-up")
        
        self.setCommonButton(id: "settingButton", imageName: "setting")
        
        self.setCommonImage(id: "possessionImageA", imageName: "posses-a-active")
        self.setCommonImage(id: "possessionImageB", imageName: "posses-b-inactive")
        
        self.setCommonImage(id: "foulCountImageA1", imageName: "foulcount-inactive")
        self.setCommonImage(id: "foulCountImageA2", imageName: "foulcount-inactive")
        self.setCommonImage(id: "foulCountImageA3", imageName: "foulcount-inactive")
        self.setCommonImage(id: "foulCountImageA4", imageName: "foulcount-inactive")
        self.setCommonImage(id: "foulCountImageA5", imageName: "foulcount-inactive")
        
        self.setCommonImage(id: "foulCountImageB1", imageName: "foulcount-inactive")
        self.setCommonImage(id: "foulCountImageB2", imageName: "foulcount-inactive")
        self.setCommonImage(id: "foulCountImageB3", imageName: "foulcount-inactive")
        self.setCommonImage(id: "foulCountImageB4", imageName: "foulcount-inactive")
        self.setCommonImage(id: "foulCountImageB5", imageName: "foulcount-inactive")
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func setCommonLabel(id: String, text: String) {
        let label = XCUIApplication().buttons[id]
        XCTAssert(label.isEnabled)
        XCTAssert(label.isHittable)
        XCTAssertEqual(label.label, text)
    }
    
    func setCommonButton(id: String, imageName: String) {
        let button = XCUIApplication().buttons[id]
        XCTAssert(button.isEnabled)
        XCTAssert(button.isHittable)
//        XCTAssertTrue(app.images[imageName].exists)
    }
    
    func setCommonImage(id: String, imageName: String) {
        let image = XCUIApplication().buttons[id]
//        XCTAssert(image.isEnabled)
//        XCTAssert(image.isHittable)
//        XCTAssertTrue(app.images[imageName].exists)
    }
    
    func testTeamNameLabel(id: String, text: String) {
        
    }
    
}
