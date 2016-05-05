//
//  HeroListViewModel.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 4/19/16.
//  Copyright © 2016 Sergey Shulga. All rights reserved.
//

import Foundation
import RxSwift

class HeroListViewModel {
   
   let mainTableItems: Observable<[Hero]>
   let searchTableItems: Observable<[Hero]>
   let dismissTrigger: Observable<Void>
   
   init(uiTriggers: (searchQuery: Observable<String>,
      nextPageTrigger: Observable<Void>,
      searchNextPageTrigger: Observable<Void>,
      dismissTrigger: Observable<Void>), remoteProvider: RemoteItemProvider<Hero>) {
      
      mainTableItems = remoteProvider.paginateItems(endPoint: EndPoint.Characters,
                                                    nextBatchTrigger: uiTriggers.nextPageTrigger)
    searchTableItems = uiTriggers.searchQuery
         .filter { !$0.isEmpty }
         .throttle(0.3, scheduler: MainScheduler.instance)
         .flatMapLatest {
            return remoteProvider.searchItems($0,
               endPoint: EndPoint.Characters,
               nextBatchTrigger: uiTriggers.searchNextPageTrigger)
        }
      dismissTrigger = uiTriggers.dismissTrigger
   }
}
