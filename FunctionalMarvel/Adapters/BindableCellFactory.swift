//
//  HeroListCellFactory.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/8/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import RxSwift

typealias BindableCell = protocol<ReusableView, BindableView, NibProvidable>

struct BindableCellFactory<Cell: BindableCell, ViewModel where Cell.V == ViewModel> {
   
}

extension BindableCellFactory where Cell: UITableViewCell {
   
   
   static func configureCellFromNib(dataSource: UITableViewDataSource,
                             tableView: UITableView,
                             indexPath: NSIndexPath,
                             viewModel: ViewModel) -> UITableViewCell {
      guard let cell: Cell = tableView.dequeueReusableCell() else {
         tableView.registerNib(Cell.nib, forCellReuseIdentifier: Cell.reuseIdentifier)
         return configureCellFromNib(dataSource, tableView: tableView, indexPath: indexPath, viewModel: viewModel)
      }
      cell.bindViewModel(viewModel)
      
      return cell
   }
   
}
