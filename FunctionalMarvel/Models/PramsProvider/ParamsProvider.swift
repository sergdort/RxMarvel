//
//  ParamsProvider.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 4/19/16.
//  Copyright © 2016 Sergey Shulga. All rights reserved.
//

import Foundation

protocol ParamsProvider {
   static var defaultParams: [String: AnyObject] {get}
   
   static func pagingListParamsForBatch(batch: Batch) -> [String: AnyObject]
   
   static func pagingListSearchParamsForQuery(query: String, batch: Batch) -> [String : AnyObject]
}

extension ParamsProvider {
   static var defaultParams: [String: AnyObject] {
      return Marvel.defaultParams
   }
}
