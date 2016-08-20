//
//  TestHelpers.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/26/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Foundation
import Runes


func delay(delay: Double, queue: dispatch_queue_t = dispatch_get_main_queue(), closure: ()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        queue, closure)
}

class JSONFileReader { }

func JSONFromFileName(name: String) -> AnyObject? {
    let path = NSBundle(forClass: JSONFileReader.self).pathForResource(name, ofType: "json")
    return JSONFromFile -<< path
}

public func JSONFromFile(path: String) -> AnyObject? {
    return NSData(contentsOfFile: path) >>- JSONObjectWithData
}

public func JSONObjectWithData(data: NSData) -> AnyObject? {
    do {
        return try NSJSONSerialization.JSONObjectWithData(data, options: [])
    } catch {
        return .None
    }
}
