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
   
   let mainTableItems: Driver<[HeroCellSection]>
   let searchTableItems: Driver<[HeroCellSection]>
   let dismissTrigger: Driver<Void>
   
   init(uiTriggers: (searchQuery: Observable<String>,
      nextPageTrigger: Observable<Void>,
      searchNextPageTrigger: Observable<Void>,
      dismissTrigger: Driver<Void>), api: HeroAPI) {
      
      mainTableItems = api
        .paginateItems(Batch.initial, endPoint: EndPoint.Characters,
            nextBatchTrigger: uiTriggers.nextPageTrigger)
        .map {
            return $0.item.map(HeroCellData.init)
        }
        .scan([HeroCellData]()) {
            return $0.0 + $0.1
        }
        .map {
            return [HeroCellSection(items: $0)]
        }
        .asDriver(onErrorJustReturn: [])

    
      searchTableItems = uiTriggers.searchQuery
         .filter { !$0.isEmpty }
         .throttle(0.3, scheduler: MainScheduler.instance)
         .flatMapLatest {
            return api.searchItems($0,
                batch: Batch.initial,
                endPoint: EndPoint.Characters,
                nextBatchTrigger: uiTriggers.searchNextPageTrigger)
         }
        .map {
            return $0.item.map(HeroCellData.init)
        }
        .scan([HeroCellData]()) {
            return $0.0 + $0.1
        }
        .map {
            return [HeroCellSection(items: $0)]
        }
        .asDriver(onErrorJustReturn: [])
    
      dismissTrigger = uiTriggers.dismissTrigger
   }
}
