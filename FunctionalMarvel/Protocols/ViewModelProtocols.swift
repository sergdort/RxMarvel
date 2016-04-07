//
//  ViewModelProtocols.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/20/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import RxSwift

protocol VariableProvidable {
   var variable: Variable<Self> {get}
}

protocol ReuseableViewClassProvider {
   var reusableViewType: ReusableView.Type {get}
}

protocol NibProvidableClassProvider {
   var nibProvidableType: NibProvidable.Type {get}
}


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
