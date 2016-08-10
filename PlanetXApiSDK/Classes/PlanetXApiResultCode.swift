//
//  PlanetXApiResultCode.swift
//  PlanetXApiSDK
//
//  Created by Steve Kim on 8/10/16.
//  Copyright © 2016 Steve Kim. All rights reserved.
//
//

import Foundation

public enum PlanetXApiErrorCode: Int {
    case
    UNKNOWN_ERROR = 99
}

func PlanetXApiGetErrorDomain(resultCode: PlanetXApiErrorCode) -> String {
    switch resultCode {
    case PlanetXApiErrorCode.UNKNOWN_ERROR:
        return "UNKNOWN_ERROR"
    default:
        return ""
    }
}