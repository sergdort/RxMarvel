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
   lazy var searchDataSource = RxTableViewSectionedReloadDataSource<HeroCellSection>()
   lazy var dataSource = RxTableViewSectionedReloadDataSource<HeroCellSection>()
   lazy var searchContentController = UITableViewController()
   lazy var searchController: UISearchController = {
      return UISearchController(searchResultsController: self.searchContentController)
   }()
   
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
      tableView.tableHeaderView = searchController.searchBar
      let input = HeroListViewModel.Input(searchQuery: searchCotroller.searchBar.rx_text.asObservable(),
                                          nextPageTrigger: tableView.rx_nextPageTriger,
                                          searchNextPageTrigger: searchContentController.tableView.rx_nextPageTriger,
                                          dismissTrigger: rightBarButton.rx_tap.asDriver())
    let viewModel = HeroListViewModel(input: input,
                                        api: DefaultHeroAPI())
    
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
   
   private func setupDataSource() {
      dataSource.configureCell = BindableCellFactory<HeroListTableViewCell, HeroCellData>.configureCellFromNib
      searchDataSource.configureCell = BindableCellFactory<HeroListTableViewCell, HeroCellData>.configureCellFromNib
      tableView.dataSource = nil
      searchContentController.tableView.dataSource = nil
   }
   
}
