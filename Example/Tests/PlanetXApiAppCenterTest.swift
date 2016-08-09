//
//  PlanetXApiAppCenterTest.swift
//  PlanetXApiSDK
//
//  Created by Steve Kim on 8/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import PlanetXApiSDK

class PlanetXApiAppCenterTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDefaultCenter() {
        XCTAssertNotNil(PlanetXApiAppCenter.defaultCenter())
    }
}
