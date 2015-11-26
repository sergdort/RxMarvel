//
//  MarvelService.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/7/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import Runes
import Argo



struct Marvel {
   
//MARK:Private
   private struct Keys {
      static let privatKey = "9597bcd0e2339d5874d9913140b581ed0b55a921"
      static let publicKey = "be23153c199affa766dc9fe6f34fd524"
   }
   
   private static let formatter:NSDateFormatter = {
      let f = NSDateFormatter()
      f.dateFormat = "yyyyMMddHHmmss"
      return f
      }()
   
   private static var defaultParams:[String:AnyObject] {
      let timeStamp = formatter.stringFromDate(NSDate())
      let hash = "\(timeStamp)\(Keys.privatKey)\(Keys.publicKey)".md5
      
      return [
         ParamKeys.apikey : Keys.publicKey,
         ParamKeys.hash : hash,
         ParamKeys.timeStamp : timeStamp
      ]
   }
}

extension Marvel:JsonGET{
   static func getData(endpoint: EndPoint)(parameters: [String : AnyObject]?) -> Observable<AnyObject> {
      return Alamofire
         .request(
            .GET,
            endpoint.path,
            parameters: defaultParams + (parameters ?? [:]))
         .rx_JSON()
   }
}




