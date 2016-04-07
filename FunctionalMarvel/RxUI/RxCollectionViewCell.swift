//
//  RxCollectionViewCell.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/21/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import RxSwift

class RxCollectionViewCell<ViewModelType>: UICollectionViewCell {
   typealias V = ViewModelType
   let onPrepareForReuse: Observable<Void> = PublishSubject()
   
   override func prepareForReuse() {
      super.prepareForReuse()
      (self.onPrepareForReuse as? PublishSubject<Void>)?.on(.Next())
   }
}
