//
//  AppendableDataSource.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/21/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import RxSwift

class AppendableDataSource<Element> : NSObject, AppendableDataSourceType, UITableViewDataSource {
   typealias T = Element
   
   var items: [T]
   
   private let cellFactory: (UITableView, NSIndexPath, T) -> UITableViewCell
   
   init(items: [T], cellFactory: (UITableView, NSIndexPath, T) -> UITableViewCell) {
      self.cellFactory = cellFactory
      self.items = items
   }
   
   func appendItems(animation: UITableViewRowAnimation, tableView: UITableView)(items: [T]) {
      if items.isEmpty {
         return
      }
      let indexPathes = (self.items.count...(self.items.count + items.count - 1)).map { (idx) in
         return NSIndexPath(forRow: idx, inSection: 0)
      }
      self.items.appendContentsOf(items)
      tableView.insertRowsAtIndexPaths(indexPathes, withRowAnimation:animation)
   }
   
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return items.count
   }
   
   func tableView(tableView: UITableView,
      cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      return cellFactory(tableView, indexPath, items[indexPath.row])
   }
}
