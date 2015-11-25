//
//  HeroListCellFactory.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/8/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import RxSwift

typealias BindableCellViewModel = protocol <VariableProvidable, ReuseableViewClassProvider, NibProvidableClassProvider>


struct BindableCellFactory<CellType:RxTableViewCell<VariableProvidable>, V:BindableCellViewModel> {
   static func cell(tableView:UITableView, indexPath:NSIndexPath, viewModel:V) -> UITableViewCell {
      if let cell = tableView.dequeueReusableCellWithIdentifier(viewModel.reusableViewType.reuseIdentifier) as? CellType {
         cell.rx_viewModel <~ viewModel.variable
         return cell
      } else {
         tableView.registerNib(viewModel.nibProvidableType.nib, forCellReuseIdentifier: viewModel.reusableViewType.reuseIdentifier)
         return cell(tableView, indexPath: indexPath, viewModel: viewModel)
      }
   }
}
