//
//  RxTableViewController.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/20/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import RxSwift

class RxTableViewController: UITableViewController {
   
   let disposableBag = DisposeBag()
   let rx_viewDidLoad:Observable<Void> = PublishSubject()
   let rx_viewWillAppear:Observable<Void> = PublishSubject()
   let rx_viewDidAppear:Observable<Void> = PublishSubject()
   let rx_viewWillDisappear:Observable<Void> = PublishSubject()
   let rx_viewDidDisappear:Observable<Void> = PublishSubject()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      (rx_viewDidLoad as? PublishSubject<Void>)?.on(.Next())
   }
   
   override func viewWillAppear(animated: Bool) {
      super.viewWillAppear(animated)
      (rx_viewWillAppear as? PublishSubject<Void>)?.on(.Next())
   }
   
   override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)
      (rx_viewDidAppear as? PublishSubject<Void>)?.on(.Next())
   }
   
   override func viewWillDisappear(animated: Bool) {
      super.viewWillDisappear(animated)
      (rx_viewWillDisappear as? PublishSubject<Void>)?.on(.Next())
   }
   
   override func viewDidDisappear(animated: Bool) {
      super.viewDidDisappear(animated)
      (rx_viewDidDisappear as? PublishSubject<Void>)?.on(.Next())
   }
   
}
