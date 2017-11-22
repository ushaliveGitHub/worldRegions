//
//  Result.swift
//  worldRegions
//
//  Created by Usha Natarajan on 9/1/17.
//  Copyright © 2017 Usha Natarajan. All rights reserved.
//

import Foundation

public let DataErrorDomain = "\(String(describing: Bundle.main.bundleIdentifier!)).DataError"
public let MissingDataError = 10

enum Result<T>{
    case success(T)
    case failure(Error)
}
