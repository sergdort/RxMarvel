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
   let offset: Int
   let limit: Int
   let total: Int
   let count: Int
}

extension Batch:Decodable {
   static func decode(json: JSON) -> Decoded<Batch> {
      return curry(Batch.init)
      <^> json <| "offset"
      <*> json <| "limit"
      <*> json <| "total"
      <*> json <| "count"
   }
}

extension Batch {
   var hasNextPage: Bool {
      return !(offset == total || offset + count == total)
   }
}

extension Batch {
   static var initial: Batch {
      return Batch(offset: 0, limit: 30, total: Int.max, count: Int.max)
   }
   
   func next() -> Batch {
      return Batch(offset: offset + count, limit: limit, total: total, count: count)
   }
   
}
