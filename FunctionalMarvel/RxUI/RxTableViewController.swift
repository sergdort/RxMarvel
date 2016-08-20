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
   override func viewDidLoad() {
      super.viewDidLoad()
      #if TRACE_RESOURCES
         print("Number of start resources = \(resourceCount)")
      #endif
   }
   deinit {
      #if TRACE_RESOURCES
         print("View controller disposed with \(RxSwift.resourceCount) resources")
         let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
         dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
            print("Number of resource after deinit \(RxSwift.resourceCount)")
         })
      #endif
   }
   
}
