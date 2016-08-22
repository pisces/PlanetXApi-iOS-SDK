//
//  PlanetXApiResultModel.swift
//  PlanetXApiSDK
//
//  Created by Steve Kim on 8/10/16.
//  Copyright © 2016 Steve Kim. All rights reserved.
//
//

import PSFoundation

public class PlanetXApiResult: AbstractJSONModel {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override public init(object: AnyObject?) {
        super.init(object: object)
    }
    
    public class tmap {
        public class FeatureResult: PlanetXApiResult {
            public var features: [PlanetXApiModel.Feature]?
            
            internal func createFeatures<T: PlanetXApiModel.Feature>(object: AnyObject?) -> [T]? {
                if object == nil {
                    return nil
                }
                
                var i = 0
                return self.childWithKey("features", classType: T.self, map: { (object: AbstractModel!) in
                    let feature = object as! PlanetXApiModel.Feature
                    if let type = feature.geometry?.type {
                        if type == PlanetXApiModel.GeometryType.Point.rawValue {
                            feature.propertiesObject?.seq = ++i
                        }
                    }
                }) as? [T]
            }
        }
        public class Routes: FeatureResult {
            override public func setProperties(object: AnyObject?) {
                super.setProperties(object)
                
                features = createFeatures(object) as [PlanetXApiModel.CarFeature]?
            }
        }
        
        public class RoutesPedestrian: FeatureResult {
            override public func setProperties(object: AnyObject?) {
                super.setProperties(object)
                
                features = createFeatures(object) as [PlanetXApiModel.WalkFeature]?
            }
        }
    }
}

public class PlanetXApiModel {
    public enum FeatureType: String {
        case
        Feature = "Feature"
    }
    
    public enum GeometryType: String {
        case
        Point = "Point",
        Line = "LineString"
    }
    
    public class Coordinate: AbstractJSONModel {
        public private(set) var latitude: Double = 0
        public private(set) var longitude: Double = 0
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override public init(object: AnyObject?) {
            super.init(object: object)
        }
    }
    
    public class Feature: AbstractJSONModel {
        private var _sourceObject: [NSObject : AnyObject]?
        public private(set) var type: String?
        public private(set) var geometry: Geometry?
        public private(set) var propertiesObject: Properties?
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override public init(object: AnyObject?) {
            super.init(object: object)
            
            _sourceObject = object as? [NSObject : AnyObject]
            
            if let object = object {
                type = object["type"] as? String
                geometry = self.childWithKey("geometry", classType: Geometry.self) as? Geometry
                
                if let geometry = geometry {
                    setPropertiesObjectBy(geometryType: geometry.type)
                }
            }
        }
        
        override public var sourceObject: [NSObject : AnyObject]! {
            return _sourceObject!
        }
        
        override public func setProperties(object: AnyObject?) {
        }
        
        internal func setPropertiesObjectBy(geometryType aType: String?) {
        }
    }
    
    public class CarFeature: Feature {
        override internal func setPropertiesObjectBy(geometryType aType: String?) {
            if aType == GeometryType.Point.rawValue {
                propertiesObject = self.childWithKey("properties", classType: WalkPointProperties.self) as? CarPointProperties
            } else if aType == GeometryType.Line.rawValue {
                propertiesObject = self.childWithKey("properties", classType: WalkLineProperties.self) as? CarLineProperties
            }
        }
    }
    
    public class WalkFeature: Feature {
        override internal func setPropertiesObjectBy(geometryType aType: String?) {
            if aType == GeometryType.Point.rawValue {
                propertiesObject = self.childWithKey("properties", classType: WalkPointProperties.self) as? WalkPointProperties
            } else if aType == GeometryType.Line.rawValue {
                propertiesObject = self.childWithKey("properties", classType: WalkLineProperties.self) as? WalkLineProperties
            }
        }
    }
    
    public class Geometry: AbstractJSONModel {
        public var type: String?
        public private(set) var coordinates: [Coordinate]?
        
        override public func format(value: AnyObject!, forKey key: String!) -> AnyObject! {
            if key == "coordinates" {
                if type == GeometryType.Point.rawValue {
                    let array = value as! [Double]
                    let dict: [String: Double] = ["longitude": array.first!, "latitude": array.last!]
                    return [Coordinate(object: dict)]
                } else if type == GeometryType.Line.rawValue {
                    let arrays = value as! [NSArray]
                    var coordinates: [Coordinate] = []
                    
                    for array in arrays {
                        let dict: [String: Double] = ["longitude": array.firstObject as! Double, "latitude": array.lastObject as! Double]
                        coordinates.append(Coordinate(object: dict))
                    }
                    
                    return coordinates
                }
            }
            
            return super.format(value, forKey: key)
        }
        
        override public func unformat(value: AnyObject!, forKey key: String!) -> AnyObject! {
            if key == "coordinates" {
                if type == GeometryType.Point.rawValue && coordinates?.first != nil {
                    return [coordinates!.first!.longitude, coordinates!.first!.latitude]
                } else if type == GeometryType.Line.rawValue && coordinates != nil {
                    var arrays: [NSArray] = []
                    
                    for coordinate in coordinates! {
                        arrays.append([coordinate.longitude, coordinate.latitude])
                    }
                    
                    return arrays
                }
            }
            
            return super.unformat(value, forKey: key)
        }
    }
    
    public class Properties: AbstractJSONModel {
        public private(set) var index: Int = 0
        public private(set) var facilityType: Int = 0
        public private(set) var seq: Int = 0
        public private(set) var descriptions: String?
        public private(set) var facilityName: String?
        public private(set) var name: String?
        
        override public func setProperties(object: AnyObject?) {
            super.setProperties(object)
            
            if let object = object {
                descriptions = object["description"] as? String
            }
        }
    }
    
    public class CarLineProperties: Properties {
        public private(set) var lineIndex: Int = 0
        public private(set) var roadType: Int = 0
        public private(set) var time: Int = 0
    }
    
    public class CarPointProperties: Properties {
        public private(set) var pointIndex: Int = 0
        public private(set) var turnType: Int = 0
        public private(set) var nextRoadName: String?
        public private(set) var pointType: String?
    }
    
    public class WalkLineProperties: Properties {
        public private(set) var pointIndex: Int = 0
        public private(set) var totalDistance: Int = 0
        public private(set) var totalTime: Int = 0
        public private(set) var turnType: Int = 0
        public private(set) var nearPoiX: Double = 0
        public private(set) var nearPoiY: Double = 0
        public private(set) var direction: String?
        public private(set) var intersectionName: String?
        public private(set) var nearPoiName: String?
        public private(set) var pointType: String?
    }
    
    public class WalkPointProperties: Properties {
        public private(set) var categoryRoadType: Int = 0
        public private(set) var distance: Int = 0
        public private(set) var lineIndex: Int = 0
        public private(set) var roadType: Int = 0
        public private(set) var time: Int = 0
    }
}