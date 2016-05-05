//
//  ViewController.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/7/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire


class HeroesListViewController: RxTableViewController {
   #if TRACE_RESOURCES
   private let startResourceCount = RxSwift.resourceCount
   #endif
   static let cellFactory = BindableCellFactory<HeroListTableViewCell, HeroCellData>.createCell
   
   private(set) lazy var dataSource: AppendableDataSource<HeroCellData> = {
      return AppendableDataSource(items: [],
                                  cellFactory: HeroesListViewController.cellFactory)
   }()
   
   lazy var searchDataSource = SearchTableDataSource<HeroCellData>(items: [],
                                                              cellFactory: HeroesListViewController.cellFactory)
   
   lazy var searchContentController: SearchTableViewController<HeroListTableViewCell, HeroCellData> = {
      return SearchTableViewController(dataSource: self.searchDataSource)
   }()
   
   lazy var searchCotroller: UISearchController = {
      return UISearchController(searchResultsController: self.searchContentController)
   }()
   
   var remoteProvider = RemoteItemProvider<Hero>(paramsProvider: HeroesParamsProvider.self)
   
   @IBOutlet var rightBarButton: UIBarButtonItem!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupBindings()
   }
   
}

//   MARK:Private

extension HeroesListViewController {
   
   private func setupBindings() {
      tableView.dataSource = dataSource
      tableView.tableHeaderView = searchCotroller.searchBar
      
      let viewModel = HeroListViewModel(uiTriggers:
         (searchQuery: searchCotroller.searchBar.rx_text.asObservable(),
         nextPageTrigger: tableView.rx_nextPageTriger,
            searchNextPageTrigger: searchContentController.tableView.rx_nextPageTriger,
            dismissTrigger: rightBarButton.rx_tap.asObservable()),
                                        remoteProvider: remoteProvider)
      
      viewModel.mainTableItems
         .map(HeroCellData.transform)
         .asDriver(onErrorJustReturn: [])
         .driveNext(dataSource.appendItems(.Top, tableView: tableView))
         .addDisposableTo(disposableBag)
      
      viewModel.searchTableItems
         .map(HeroCellData.transform)
         .asDriver(onErrorJustReturn: [])
         .driveNext(searchContentController.dataSource
            .setItems(.Top,
               tableView: searchContentController.tableView))
         .addDisposableTo(disposableBag)
      
      viewModel.dismissTrigger.asDriver(onErrorJustReturn: ())
         .driveNext { [weak self] in
            self?.dismissViewControllerAnimated(true, completion: nil)
         }
         .addDisposableTo(disposableBag)
   }
   
}
