//
//  SearchTableDataSource.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/27/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit

class SearchTableDataSource<Element>: AppendableDataSource<Element> {
   
   override init(items: [T],
      cellFactory: (UITableView, NSIndexPath, T) -> UITableViewCell) {
      super.init(items: items, cellFactory: cellFactory)
   }
}


extension SearchTableDataSource:ChangeableDataSourceType {
   func setItems(animation: UITableViewRowAnimation, tableView: UITableView)(items: [T]) {
      self.items = items
      tableView.reloadData()
   }
}
