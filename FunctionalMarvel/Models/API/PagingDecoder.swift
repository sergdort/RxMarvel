//
//  PagingDecoder.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 4/15/16.
//  Copyright © 2016 Sergey Shulga. All rights reserved.
//

import Foundation
import Argo

struct PagingParser<T: JSONParsable> {
   
   static func parse(json: AnyObject) throws -> Page<[T]> {
      if let data = JSONDict(json)(key: "data"),
         let items: Decoded<[T]> = T.parse(json) {
         let batch: Decoded<Batch> = decode(data)
         return try Page(item: items.dematerialize(), batch: batch.dematerialize())
      }
      throw DecodeError.Custom("Invalid JSON")
   }
}
