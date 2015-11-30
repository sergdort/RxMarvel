//
//  SearchAdapter.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/27/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct SearchViewModel<T> {
   var searchQuery = ""
   var items = [T]()
}

class TableSearchAdapter<Element, U:BindableCellViewModel> {
   
   typealias TableSearchAdapterSearchMap = (offset:Int, limit:Int, search:String, nexBatchTriger:Observable<Void>) -> Observable<[Element]>
   
   lazy var searchController:UISearchController = {
      return UISearchController(searchResultsController: self.searchContentController)
   }()
   lazy var searchContentController = SearchTableViewController<U>(style:.Plain)
   private let searchMap:TableSearchAdapterSearchMap
   private let toViewModelMap:([Element] -> [U])
   private var query = ""
   let bag = DisposeBag()
   
   init(searchMaper:TableSearchAdapterSearchMap, toViewModelMap:[Element] -> [U]) {
      self.searchMap = searchMaper
      self.toViewModelMap = toViewModelMap
      let searchSignal = searchController.searchBar
         .rx_text
         .throttle(0.3, MainScheduler.sharedInstance)
         .distinctUntilChanged()
         .flatMapLatest { [unowned self] (search) -> Observable<[U]> in
            if search.isEmpty {
               return empty()
            }
            return self.searchMap(offset: 0,
               limit: 10,
               search: search,
               nexBatchTriger:self.searchContentController.tableView.rxex_nextPageTriger)
               .map(self.toViewModelMap)
      }
      
      searchSignal
         .filter({ [unowned self] items -> Bool in
            return self.searchContentController.dataSource.items.isEmpty
         })
         .asDriver(onErrorJustReturn: [])
         .driveNext(searchContentController.dataSource.appendItems(.Top))
         .addDisposableTo(bag)
      
      searchSignal
         .filter({ [unowned self] items -> Bool in
            return self.searchContentController.dataSource.items.isEmpty == false
         })
         .asDriver(onErrorJustReturn: [])
         .driveNext(searchContentController.dataSource.setItems(.Top))
         .addDisposableTo(bag)
      
   }
   
   deinit {
      print("deinit \(self)")
   }
   
}
