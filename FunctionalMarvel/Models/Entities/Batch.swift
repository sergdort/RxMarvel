//
//  Butch.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/10/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Foundation
import Argo
import Curry

struct Batch {
   let offset:Int
   let limit:Int
   let total:Int
   let count:Int
}

extension Batch:Decodable {
   static func decode(j: JSON) -> Decoded<Batch> {
      return curry(Batch.init)
      <^> j <| "offset"
      <*> j <| "limit"
      <*> j <| "total"
      <*> j <| "count"
   }
}