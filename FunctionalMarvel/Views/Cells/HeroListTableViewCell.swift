//
//  HeroListTableViewCell.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/20/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit.UITableViewCell
import RxSwift

class HeroListTableViewCell: RxTableViewCell<VariableProvidable> {
   @IBOutlet weak var cellImageView: UIImageView!
   @IBOutlet weak var label: UILabel!
   
   override var rx_viewModel: AnyObserver<VariableProvidable> {
      return AnyObserver { [weak self] event in
         MainScheduler.ensureExecutingOnScheduler()
         
         switch event {
         case .Next(let value):
            if let strong = self,
               vm = value as? HeroListViewModel {
               strong.label.rx_text <~ vm.title
               strong.cellImageView.rxex_imageURL <~ vm.thumbnailPath
            }
         default:
            break
         }
      }
   }
}


extension HeroListTableViewCell:ReusableView {
}

extension HeroListTableViewCell:NibProvidable{
}

