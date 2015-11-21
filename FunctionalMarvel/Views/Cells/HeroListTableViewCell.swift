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
   
   override var rx_viewModel: ObserverOf<VariableProvidable> {
      return ObserverOf { [weak self] event in
         MainScheduler.ensureExecutingOnScheduler()
         
         switch event {
         case .Next(let value):
            if let strong = self,
               viewModel = value as? HeroListViewModel {
               strong.label.rx_text <~ viewModel.title
               strong.cellImageView.rx_imageURL <~ viewModel.thumbnailPath
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

