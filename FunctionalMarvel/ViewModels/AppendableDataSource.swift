//
//  AppendableDataSource.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/21/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import RxSwift

class AppendableDataSource<Element> : NSObject, AppendableDataSourceType,UITableViewDataSource {
   typealias T = Element
   private(set) var items:[T]
   private weak var tableView:UITableView?
   private let cellFactory:(UITableView, NSIndexPath, T) -> UITableViewCell
   
   init(items:[T], tableView:UITableView ,cellFactory:(UITableView, NSIndexPath, T) -> UITableViewCell) {
      self.cellFactory = cellFactory
      self.items = items
      self.tableView = tableView
   }
   
   func appendItems(animation:UITableViewRowAnimation)(items:[T]) {
      if items.isEmpty {
         return
      }
      let indexPathes = (self.items.count...(self.items.count + items.count - 1)).map { (i) in
         return NSIndexPath(forRow: i, inSection: 0)
      }
      self.items.appendContentsOf(items)
      self.tableView?.insertRowsAtIndexPaths(indexPathes, withRowAnimation:animation)
   }
   
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return items.count
   }
   
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      return cellFactory(tableView, indexPath, items[indexPath.row])
   }
   
}
