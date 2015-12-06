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

class TableSearchAdapter<Element, U:BindableCellViewModel> {
   
   typealias SearchEvent = (offset:Int, limit:Int, search:String, nexBatchTriger:Observable<Void>) -> Observable<[Element]>
   
   lazy var searchController:UISearchController = {
      return UISearchController(searchResultsController: self.searchContentController)
   }()
   lazy var searchContentController = SearchTableViewController<U>(style:.Plain)
   
   let bag = DisposeBag()
   
   init(searchEvent:SearchEvent, viewModelMap:[Element] -> [U]) {
      let searchSignal = searchController.searchBar
         .rx_text
         .throttle(0.3, MainScheduler.sharedInstance)
         .distinctUntilChanged()
         .flatMapLatest { [unowned self] (search) -> Observable<[U]> in
            if search.isEmpty {
               return empty()
            }
            return searchEvent(offset: 0,
               limit: 10,
               search: search,
               nexBatchTriger:self.searchContentController.tableView.rxex_nextPageTriger)
               .map(viewModelMap)
      }
      
      searchSignal
         .filter({ [unowned self] items -> Bool in
            return self.searchContentController.dataSource.items.isEmpty
         })
         .asDriver(onErrorJustReturn: [])
         .driveNext(searchContentController.dataSource.appendItems(.Top, tableView: searchContentController.tableView))
         .addDisposableTo(bag)
      
      searchSignal
         .filter({ [unowned self] items -> Bool in
            return self.searchContentController.dataSource.items.isEmpty == false
         })
         .asDriver(onErrorJustReturn: [])
         .driveNext(searchContentController.dataSource.setItems(.Top, tableView: searchContentController.tableView))
         .addDisposableTo(bag)
      
   }
   
   deinit {
      print("deinit \(self)")
   }
   
}
