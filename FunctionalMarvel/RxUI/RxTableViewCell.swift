//
//  RxTableViewCell.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/8/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import RxSwift

class RxTableViewCell<ViewModelType>: UITableViewCell, BindableView {
    typealias V = ViewModelType
    let rx_prepareForReuse: Observable<Void> = PublishSubject()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        guard let rx_prepareForReuse = rx_prepareForReuse as? PublishSubject else { return }
        rx_prepareForReuse.onNext()
    }
    
    var rx_viewModel: AnyObserver<V> {
        return AnyObserver { event in
            //         This is base class implementation
        }
    }
    
}

