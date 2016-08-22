//
//  PlanetXApiAppCenterTest.swift
//  PlanetXApiSDK
//
//  Created by Steve Kim on 8/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PlanetXApiSDK

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
    
    func testGetAppKey() {
        let appKey = "d1a2f50e-eb1b-3042-975c-6426d743da13"
        
        XCTAssertEqual(appKey, PlanetXApiAppCenter.defaultCenter().appKey)
    }
    
    func testCallRoutesPredesrian() {
        let expectation = expectationWithDescription("testCallRoutesPredesrian")
        
        let param = PlanetXApiParameterSet.tmap.RoutesPedestrian()
        param.startX = 127.010245
        param.startY = 37.489199
        param.endX = 127.1022888
        param.endY = 37.6019593
        param.startName = "서울시 서초구 반포대로 22길 19-8"
        param.endName = "서울시 중랑구 망우동 343-9"
        
        PlanetXApiAppCenter.defaultCenter().call(path: PlanetXApiPath.tmapRoutesPedestrian, params: param) { (result: PlanetXApiResult.tmap.RoutesPedestrian?, error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
        }
    }
    
    func testCallRoutes() {
        let expectation = expectationWithDescription("testCallRoutes")
        
        let param = PlanetXApiParameterSet.tmap.Routes()
        param.startX = 127.010245
        param.startY = 37.489199
        param.endX = 127.1022888
        param.endY = 37.6019593
        param.startName = "서울시 서초구 반포대로 22길 19-8"
        param.endName = "서울시 중랑구 망우동 343-9"
        
        PlanetXApiAppCenter.defaultCenter().call(path: PlanetXApiPath.tmapRoutes, params: param) { (result: PlanetXApiResult.tmap.RoutesPedestrian?, error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
        }
    }
}
