//
//  HeroListCellFactory.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/8/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import RxSwift

typealias BindableCellViewModel = protocol <VariableProvidable, ReuseableViewClassProvidable>

struct BindableCellFactory<T:RxTableViewCell<VariableProvidable>, V:BindableCellViewModel> {
   
   static func cell(tableView:UITableView, index:Int, viewModel:V) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(viewModel.reusableViewClass.reuseIdentifier) as! T
      
      cell.rx_viewModel <~ viewModel.variable
      
      return cell
   }
}
