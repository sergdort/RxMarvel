//
//  HeroListViewModel.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 4/19/16.
//  Copyright © 2016 Sergey Shulga. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HeroListViewModel {
    struct Input {
        let searchQuery: Observable<String>
        let nextPageTrigger: Observable<Void>
        let searchNextPageTrigger: Observable<Void>
        let dismissTrigger: Driver<Void>
    }
   let mainTableItems: Driver<[HeroCellSection]>
   let searchTableItems: Driver<[HeroCellSection]>
   let dismissTrigger: Driver<Void>
   
    init(input: Input, api: HeroAPI, scheduler: SchedulerType = MainScheduler.instance) {
    
    
    searchTableItems = input.searchQuery
        .filter { !$0.isEmpty }.debug("filter")
        .throttle(0.3, scheduler: scheduler)//2
        .debug("throttle")
        .flatMapLatest { //3
            return api.searchItems($0,
                batch: Batch.initial,
                endPoint: EndPoint.Characters,
                nextBatchTrigger: input.searchNextPageTrigger)
               .catchError { _ in
                  return Observable.empty()
               }
        }
        .map { //4
            return $0.map(HeroCellData.init)
        }
        .map {//5
            return [HeroCellSection(items: $0)]
        }
        .asDriver(onErrorJustReturn: [])
    

      mainTableItems = api
        .paginateItems(Batch.initial,
            endPoint: EndPoint.Characters,
            nextBatchTrigger: input.nextPageTrigger)
        .map {
            return [HeroCellSection(items: $0.map(HeroCellData.init))]
        }
        .asDriver(onErrorJustReturn: [])

    
      dismissTrigger = input.dismissTrigger
   }
}
