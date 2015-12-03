//
//  SearchTableViewController.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/27/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit

class SearchTableViewController<T:BindableCellViewModel>: RxTableViewController {
   lazy var dataSource:SearchTableDataSource<T> = {
      return SearchTableDataSource(items: [],
         tableView: self.tableView,
         cellFactory: BindableCellFactory.cell)
   }()
   
   override init(style: UITableViewStyle) {
      super.init(style: style)
      self.edgesForExtendedLayout = .All
   }
   
   override func viewWillAppear(animated: Bool) {
      super.viewWillAppear(animated)
      tableView.dataSource = dataSource
   }
   
}
