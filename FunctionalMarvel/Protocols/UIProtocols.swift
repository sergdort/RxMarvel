//
//  UIProtocols.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/20/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import RxSwift

protocol ReusableView {
   static var reuseIdentifier: String {get}
}

protocol BindableView {
   associatedtype V
   var rx_viewModel: AnyObserver<V> {get}
}

extension ReusableView {
   static var reuseIdentifier: String {
      return "\(self)"
   }
}

protocol NibProvidable {
   static var nibName: String {get}
   static var nib: UINib {get}
}

extension NibProvidable {
   static var nibName: String {
      return "\(self)"
   }
   static var nib: UINib {
      return UINib(nibName: self.nibName, bundle: nil)
   }
}
