//
//  Pagination.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/8/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct Pagination {
   
   static private let startLoadingOffset:CGFloat = 40
   
   static func shouldLoadNextBatch(offset:CGPoint, table:UITableView) -> Bool {
      let result = offset.y + table.frame.size.height + startLoadingOffset > table.contentSize.height
      
      if result {
         print("should load")
      }
      
      return result
   }
   
   static func nextPageTriger(tableView:UITableView) -> Observable<Void> {
      return tableView
         .rx_contentOffset
         .flatMap({ (offset) in
            shouldLoadNextBatch(offset, table: tableView) ? just() : empty()
         })
   }
   
}