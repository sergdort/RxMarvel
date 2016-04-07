//
//  SearchTableViewController.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/27/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit

class SearchTableViewController<Cell: BindableCell, T where  Cell.V == T>: RxTableViewController {
   let dataSource: SearchTableDataSource<T>
   
   init(style: UITableViewStyle = .Plain, dataSource: SearchTableDataSource<T>) {
      self.dataSource = dataSource
      super.init(style: style)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      tableView.dataSource = dataSource
   }
   
}
