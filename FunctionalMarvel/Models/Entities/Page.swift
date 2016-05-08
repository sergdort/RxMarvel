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

extension ObservableType {
   func paginate<O: ObservableType>(nextPageTrigger: O,
                 hasNextPage: E -> Bool,
                 nextPageFactory: E -> Observable<E>) -> Observable<E> {
      return flatMap { page -> Observable<E> in
         if !hasNextPage(page) {
            return Observable.just(page)
         }
         return [
            Observable.just(page),
            Observable.never().takeUntil(nextPageTrigger),
            nextPageFactory(page)
         ].concat()
      }
   }
}
