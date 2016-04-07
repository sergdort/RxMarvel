//
//  ViewModelProtocols.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/20/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import RxSwift

protocol AppendableDataSourceType {
   associatedtype T
   
   func appendItems(animation: UITableViewRowAnimation, tableView: UITableView)
      -> (items: [T])
      -> Void
}

protocol ChangeableDataSourceType {
   associatedtype T
   
   func setItems(animation: UITableViewRowAnimation, tableView: UITableView)
      -> (items: [T])
      -> Void
}
