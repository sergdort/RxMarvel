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
   
   #if TRACE_RESOURCES
   private let startResourceCount = RxSwift.resourceCount
   #endif
   
   let disposableBag = DisposeBag()
   let rx_viewDidLoad:Observable<Void> = PublishSubject()
   let rx_viewWillAppear:Observable<Void> = PublishSubject()
   let rx_viewDidAppear:Observable<Void> = PublishSubject()
   let rx_viewWillDisappear:Observable<Void> = PublishSubject()
   let rx_viewDidDisappear:Observable<Void> = PublishSubject()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      #if TRACE_RESOURCES
         print("Number of start resources = \(resourceCount)")
      #endif
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
   
   deinit {
      #if TRACE_RESOURCES
         print("deinit \(self)")
         print("View controller disposed with \(resourceCount) resources")
         
         let numberOfResourcesThatShouldRemain = startResourceCount
         let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
         dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
            assert(resourceCount <= numberOfResourcesThatShouldRemain, "Resources weren't cleaned properly \(resourceCount)")
         })
      #endif
   }
   
}
