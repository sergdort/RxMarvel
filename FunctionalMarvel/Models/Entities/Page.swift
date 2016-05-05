//
//  Page.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 4/18/16.
//  Copyright © 2016 Sergey Shulga. All rights reserved.
//

import Foundation
import protocol RxSwift.ObservableType
import class RxSwift.Observable

protocol PageType {
   associatedtype T
   
   var item: T {get}
   var batch: Batch {get}
}

struct Page<Element>: PageType {
   typealias T = Element
   
   let item: Element
   let batch: Batch
}

extension ObservableType where E: PageType {
   
   @warn_unused_result(message="http://git.io/rxs.uo")
   func paginate(nextPageTrigger: Observable<Void>,
                 nextPageFactory: (Batch) -> Observable<E.T>) -> Observable<E.T> {
      return self.flatMap { [weak nextPageTrigger] page -> Observable<E.T> in
         if !page.batch.hasNextPage {
            return Observable.just(page.item)
         }
         return [
            Observable.just(page.item),
            Observable.never().takeUntil(nextPageTrigger ?? Observable.empty()),
            nextPageFactory(page.batch)
            ].concat()
      }
   }
}