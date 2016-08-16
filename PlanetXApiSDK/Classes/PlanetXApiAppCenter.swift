//
//  PlanetXApiAppCenter.swift
//  PlanetXApiSDK
//
//  Created by Steve Kim on 8/10/16.
//  Copyright © 2016 Steve Kim. All rights reserved.
//
//

import Foundation
import w3action

public enum PlanetXApiPath: String {
    case
    tmapRoutesPedestrian = "tmap/routes/pedestrian"
}

public class PlanetXApiAppCenter: NSObject {
    
    // MARK: - Constant
    
    
    let kPlanetXApiBasePath = "https://apis.skplanetx.com/"
    let kPlanetXApiAppKey = "PlanetXApiAppKey"
    let kPlanetXApiHeadersAppKey = "appKey"
    
    // MARK: - Properties
    
    public private(set) var appKey: String?
    public var version: String = "1"
    
    // MARK: - Overridden: NSObject
    
    override init() {
        if let appKey: String = NSBundle.mainBundle().objectForInfoDictionaryKey(kPlanetXApiAppKey) as? String {
            self.appKey = appKey.stringByRemovingPercentEncoding
        } else {
            #if DEBUG
                print("PlanetXApiAppKey does not exist in info plist file!")
            #endif
        }
    }
    
    public func call<T: PlanetXApiParameterSet, Y: PlanetXApiResult>(path aPath: PlanetXApiPath,
                     params: T?,
                     completion: ((result: Y?, error: NSError?) -> Void)?) -> NSURLSessionDataTask {
        return HTTPActionManager.sharedInstance().doActionWithRequestObject(
            requestObjectWithPath(aPath, params: params, completion: completion),
            success: {(result: AnyObject?) -> Void in
                if (result != nil && completion != nil) {
                    if let dict = result as? NSDictionary {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                            let model = Y(object: dict)
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                completion!(result: model, error: nil)
                            }
                        }
                    } else {
                        completion!(result: nil, error: NSError(domain: PlanetXApiGetErrorDomain(PlanetXApiErrorCode.UNKNOWN_ERROR), code: PlanetXApiErrorCode.UNKNOWN_ERROR.rawValue, userInfo: nil))
                    }
                }
            }, error: {(error: NSError?) -> Void in
                if (completion != nil) {
                    completion!(result: nil, error: error)
                }
        }).sessionDataTask
    }
    
    // MARK: - Public methods
    
    static public func defaultCenter() -> PlanetXApiAppCenter {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: PlanetXApiAppCenter? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = PlanetXApiAppCenter()
        }
        return Static.instance!
    }
    
    // MARK: - Private methods
    
    private func requestObjectWithPath<T: PlanetXApiParameterSet, Y: PlanetXApiResult>(path: PlanetXApiPath,
                                       params: T?,
                                       completion: ((result: Y?, error: NSError?) -> Void)?) -> HTTPRequestObject {
        let url: String = "\(kPlanetXApiBasePath)\(path.rawValue)?version=\(version)"
        
        let object: HTTPRequestObject = HTTPRequestObject()
        object.headers = [kPlanetXApiHeadersAppKey: appKey!]
        object.param = params!.dictionary
        object.action = ["url": url,
                         "method": HTTPRequestMethodPost,
                         "contentType": ContentTypeApplicationXWWWFormURLEncoded,
                         "dataType": DataTypeJSON,
                         "timeout": (10),
                         "async": (true)]
        return object
    }
}
