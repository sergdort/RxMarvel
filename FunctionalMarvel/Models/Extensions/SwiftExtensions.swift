//
//  SwiftExtensions.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/7/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Foundation
import Runes

func JSONDict(j:AnyObject) -> [String : AnyObject]? {
   return j as?  [String : AnyObject]
}

func JSONDict(j:AnyObject)(key:String) -> [String : AnyObject]? {
   if let dict = JSONDict -<< j {
      return JSONDict -<< dict[key]
   }
   return nil
}

func JSONArray(j:AnyObject) -> Array<[String : AnyObject]>? {
   return j as? Array<[String : AnyObject]>
}

func + <T, U>(var lhs: [T: U], rhs: [T: U]) -> [T: U] {
   for (key, val) in rhs {
      lhs[key] = val
   }
   
   return lhs
}

extension String {
   func md5() -> String {
      let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
      let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
      let digestLen = Int(CC_MD5_DIGEST_LENGTH)
      let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
      
      CC_MD5(str!, strLen, result)
      
      let hash = NSMutableString()
      for i in 0..<digestLen {
         hash.appendFormat("%02x", result[i])
      }
      
      result.destroy()
      
      return hash as String
   }
}