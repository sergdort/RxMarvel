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
    
    private(set) var disposableBag = DisposeBag()
    
    let rx_viewDidLoad: Observable<Void> = PublishSubject()
    let rx_viewWillAppear: Observable<Void> = PublishSubject()
    let rx_viewDidAppear: Observable<Void> = PublishSubject()
    let rx_viewWillDisappear: Observable<Void> = PublishSubject()
    let rx_viewDidDisappear: Observable<Void> = PublishSubject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        #if TRACE_RESOURCES
            print("Number of start resources = \(resourceCount)")
        #endif
        
        guard let rx_viewDidLoad = rx_viewDidLoad as? PublishSubject else { return }
        rx_viewDidLoad.onNext()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let rx_viewWillAppear = rx_viewWillAppear as? PublishSubject else { return }
        rx_viewWillAppear.onNext()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let rx_viewDidAppear = rx_viewDidAppear as? PublishSubject else { return }
        rx_viewDidAppear.onNext()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let rx_viewWillDisappear = rx_viewWillDisappear as? PublishSubject else { return }
        rx_viewWillDisappear.onNext()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard let rx_viewDidDisappear = rx_viewDidDisappear as? PublishSubject else { return }
        rx_viewDidDisappear.onNext()
    }
    
    deinit {
        #if TRACE_RESOURCES
            print("deinit \(self)")
            print("View controller disposed with \(RxSwift.resourceCount) resources")
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                print("Number of resource after deinit \(RxSwift.resourceCount)")
            })
        #endif
    }
    
}
