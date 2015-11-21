//
//  ViewModelProtocols.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/20/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import RxSwift

protocol VariableProvidable {
   var variable:Variable<VariableProvidable> {get}
}

protocol ReuseableViewClassProvidable {
   var reusableViewClass:ReusableView.Type {get}
}
