//
//  SwiftExtensions.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/7/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Foundation
import Runes

func JSONDict(j: AnyObject) -> [String : AnyObject]? {
   return j as?  [String : AnyObject]
}

func JSONDict(j: AnyObject) -> (key: String) -> [String : AnyObject]? {
   return { key in
      if let dict = JSONDict -<< j {
         return JSONDict -<< dict[key]
      }
      return nil
   }
}

func JSONArray(j: AnyObject) -> Array<[String : AnyObject]>? {
   return j as? Array<[String : AnyObject]>
}

func + <T, U>(lhs: [T: U], rhs: [T: U]) -> [T: U] {
   var lhsCopy = lhs
   for (key, val) in rhs {
      lhsCopy[key] = val
   }
   
   return lhsCopy
}

extension String {
   var md5: String {
      let str = cStringUsingEncoding(NSUTF8StringEncoding) ?? []
      let strLen = CUnsignedInt(lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
      let digestLen = Int(CC_MD5_DIGEST_LENGTH)
      let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
      
      CC_MD5(str, strLen, result)
      
      var hash = String()
      for i in 0..<digestLen {
         hash += String(format: "%02x", result[i])
      }
      
      result.destroy()
      
      return hash
   }
}

extension UIApplication {
   static var appDelegate: AppDelegate {
      guard let app = UIApplication.sharedApplication().delegate as? AppDelegate else {
         fatalError()
      }
      return app
   }
}
