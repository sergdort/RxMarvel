//
//  HeroListTableViewCell.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/20/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit.UITableViewCell
import RxSwift

class HeroListTableViewCell: RxTableViewCell, ReusableView, NibProvidable {
   @IBOutlet weak var cellImageView: UIImageView!
   @IBOutlet weak var label: UILabel!
}


extension HeroListTableViewCell: BindableView {
   typealias V = HeroCellData
   
   func bindViewModel(viewModel: V) {
      label.text = viewModel.title
      _ = Observable.just(viewModel.thumbnailURL)
         .takeUntil(onPrepareForReuse)
         .bindTo(cellImageView.rxex_imageURL)
   }
}
