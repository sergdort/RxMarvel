//
//  HeroesParamsProvider.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 4/19/16.
//  Copyright © 2016 Sergey Shulga. All rights reserved.
//

import Foundation

class HeroesParamsProvider: ParamsProvider {
   
   static func pagingListParamsForBatch(batch: Batch) -> [String: AnyObject] {
      let params: [String : AnyObject] = [ ParamKeys.limit : batch.limit,
                                           ParamKeys.offset : batch.offset]

      return defaultParams + params
   }
   
   static func pagingListSearchParamsForQuery(query: String,
                                              batch: Batch) -> [String : AnyObject] {
      return defaultParams + pagingListParamsForBatch(batch) + [ParamKeys.searchName : query]
   }
}
