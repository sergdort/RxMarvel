//
//  HeroListTableViewCell.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/20/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit.UITableViewCell
import RxSwift

class HeroListTableViewCell: RxTableViewCell<HeroListViewModel> {
   @IBOutlet weak var cellImageView: UIImageView!
   @IBOutlet weak var label: UILabel!
   
   override var rx_viewModel: AnyObserver<HeroListViewModel> {
      return AnyObserver { [weak self] event in
         MainScheduler.ensureExecutingOnScheduler()
         
         switch event {
         case .Next(let value):
            if let strong = self {
               strong.label.rx_text <~ value.title
               strong.cellImageView.rxex_imageURL <~ value.thumbnailPath
            }
         default:
            break
         }
      }
   }
}


extension HeroListTableViewCell: ReusableView {
}

extension HeroListTableViewCell: NibProvidable {
}
