//
//  PlanetXApiParameterSet.swift
//  PlanetXApiSDK
//
//  Created by Steve Kim on 8/10/16.
//  Copyright © 2016 Steve Kim. All rights reserved.
//
//

import PSFoundation

public class PlanetXApiParameterSet: AbstractModel {
    
    public class tmap {
        public class Routes: PlanetXApiParameterSet {
            public var endX: Double = 0
            public var endY: Double = 0
            public var startX: Double = 0
            public var startY: Double = 0
            public var endPoiId: Int = 0
            public var endRpFlag: Int = 4
            public var reqCoordType: String = "WGS84GEO"
            public var resCoordType: String = "WGS84GEO"
            public var endName: String?
            public var startName: String?
        }
        
        public class RoutesPedestrian: PlanetXApiParameterSet {
            public var angle: Float = 1
            public var speed: Float = 60
            public var endX: Double = 0
            public var endY: Double = 0
            public var startX: Double = 0
            public var startY: Double = 0
            public var endPoiId: Int = 0
            public var endRpFlag: Int = 4
            public var searchOption: Int = 0
            public var gpsTime: UInt = 15000
            public var reqCoordType: String = "WGS84GEO"
            public var resCoordType: String = "WGS84GEO"
            public var endName: String?
            public var startName: String?
        }
    }
}
