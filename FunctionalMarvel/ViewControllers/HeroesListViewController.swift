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
import RxDataSources


class HeroesListViewController: RxTableViewController {
   #if TRACE_RESOURCES
   private let startResourceCount = RxSwift.resourceCount
   #endif
   static let cellFactory = BindableCellFactory<HeroListTableViewCell, HeroCellData>.createCell
   
   lazy var searchDataSource = RxTableViewSectionedReloadDataSource<HeroCellSection>()
   
   lazy var searchContentController = UITableViewController()
   
   lazy var dataSource = RxTableViewSectionedReloadDataSource<HeroCellSection>()
   
   lazy var searchCotroller: UISearchController = {
      return UISearchController(searchResultsController: self.searchContentController)
   }()
   
   var remoteProvider = RemoteItemProvider<Hero>(paramsProvider: HeroesParamsProvider.self)
   
   @IBOutlet var rightBarButton: UIBarButtonItem!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupDataSource()
      setupBindings()
   }
   
}

//   MARK:Private

extension HeroesListViewController {
   
   private func setupBindings() {
      tableView.tableHeaderView = searchCotroller.searchBar
      
      let viewModel = HeroListViewModel(uiTriggers:
         (searchQuery: searchCotroller.searchBar.rx_text.asObservable(),
         nextPageTrigger: tableView.rx_nextPageTriger,
            searchNextPageTrigger: searchContentController.tableView.rx_nextPageTriger,
            dismissTrigger: rightBarButton.rx_tap.asDriver()),
                                        api: DefaultHeroAPI(paramsProvider: HeroesParamsProvider.self))
      
      tableView.dataSource = nil
      searchContentController.tableView.dataSource = nil
      viewModel.mainTableItems
         .drive(tableView.rx_itemsWithDataSource(dataSource))
         .addDisposableTo(disposableBag)
      
      viewModel.searchTableItems
         .drive(searchContentController.tableView.rx_itemsWithDataSource(searchDataSource))
         .addDisposableTo(disposableBag)
      
      viewModel.dismissTrigger.asDriver(onErrorJustReturn: ())
         .driveNext { [weak self] in
            self?.dismissViewControllerAnimated(true, completion: nil)
         }
         .addDisposableTo(disposableBag)
   }
   
   func setupDataSource() {
      dataSource.configureCell = BindableCellFactory<HeroListTableViewCell, HeroCellData>.configureCell
      searchDataSource.configureCell = BindableCellFactory<HeroListTableViewCell, HeroCellData>.configureCell
      tableView.dataSource = nil
      searchContentController.tableView.dataSource = nil
   }
   
}
