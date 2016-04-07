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
   func bindViewModel(viewModel: V)
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

extension UITableView {
   
   func dequeueReusableCell<T: UITableViewCell where T: ReusableView>(forIndexPath
      indexPath: NSIndexPath)
      -> T {
      guard let cell = dequeueReusableCellWithIdentifier(T.reuseIdentifier, forIndexPath: indexPath)
         as? T else {
         fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
      }
      
      return cell
   }
   
   func dequeueReusableCell<T: UITableViewCell where T: ReusableView>() -> T? {
      return dequeueReusableCellWithIdentifier(T.reuseIdentifier) as? T
   }
   
}
