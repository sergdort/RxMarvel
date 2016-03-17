//
//  SearchTableViewController.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/27/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit

class SearchTableViewController<T:BindableCellViewModel>: RxTableViewController {
   lazy var dataSource: SearchTableDataSource<T> = {
      return SearchTableDataSource(items: [],
         cellFactory: BindableCellFactory.cell)
   }()
   
   override init(style: UITableViewStyle) {
      super.init(style: style)
      edgesForExtendedLayout = .All
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      tableView.dataSource = dataSource
   }
   
}
