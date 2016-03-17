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
   
   private(set) lazy var dataSource: AppendableDataSource<HeroListViewModel> = {
      return AppendableDataSource(items: [],
         cellFactory: BindableCellFactory.cell)
   }()
   
   lazy var searchAdapter: TableSearchAdapter<Hero, HeroListViewModel> = {
      return TableSearchAdapter(searchEvent: self.api.searchItems,
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
   
//   MARK:Private
   
   private func setupTableView() {
      tableView.delegate = nil
      tableView.dataSource = dataSource
      tableView.tableHeaderView = searchAdapter.searchController.searchBar
   }
   
   private func loadData() {
      api.getItems(dataSource.items.count, limit: 40, loadNextBatch: tableView.rxex_nextPageTriger)
         .map(HeroListViewModel.transform)
         .asDriver(onErrorJustReturn: [])
         .driveNext(dataSource.appendItems(.Top, tableView: tableView))
         .addDisposableTo(disposableBag)
   }
   
}
