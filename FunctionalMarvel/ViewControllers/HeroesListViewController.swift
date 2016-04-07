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


class HeroesListViewController: RxTableViewController {
   #if TRACE_RESOURCES
   private let startResourceCount = RxSwift.resourceCount
   #endif
   static let cellFactory = BindableCellFactory<HeroListTableViewCell, HeroListViewModel>.createCell
   
   private(set) lazy var dataSource: AppendableDataSource<HeroListViewModel> = {
      return AppendableDataSource(items: [],
         cellFactory: HeroesListViewController.cellFactory)
   }()
   
   lazy var searchAdapter: TableSearchAdapter<Hero, HeroListViewModel, HeroListTableViewCell> = {
      let dataSource: SearchTableDataSource<HeroListViewModel> =
         SearchTableDataSource(items: [],
                               cellFactory: HeroesListViewController.cellFactory)
      
      let searchController: SearchTableViewController<HeroListTableViewCell, HeroListViewModel>
         = SearchTableViewController(dataSource: dataSource)
      
      return TableSearchAdapter(searchContentController: searchController,
                                       searchEvent: self.api.searchItems,
                                       viewModelMap: HeroListViewModel.transform)
   }()
   
   lazy var api: HeroAutoLoading.Type = HeroAPI.self
   
   @IBOutlet var rightBarButton: UIBarButtonItem!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setupTableView()
      loadData()
      Segue.dismissSegueFromViewController(self, triger: rightBarButton.rx_tap)
   }
   
}

//   MARK:Private

extension HeroesListViewController {
   private func setupTableView() {
      tableView.dataSource = dataSource
      tableView.tableHeaderView = searchAdapter.searchController.searchBar
   }
   
   private func loadData() {
      api.getItems(dataSource.items.count, limit: 40, loadNextBatch: tableView.rx_nextPageTriger)
         .map(HeroListViewModel.transform)
         .asDriver(onErrorJustReturn: [])
         .driveNext(dataSource.appendItems(.Top, tableView: tableView))
         .addDisposableTo(disposableBag)
   }
}
