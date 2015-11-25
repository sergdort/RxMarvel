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
   private(set) lazy var dataSource:AppendableDataSource<HeroListViewModel> = {
      return AppendableDataSource(items: [],
         tableView: self.tableView,
         cellFactory: BindableCellFactory.cell)
   }()
   
   lazy var api:HeroAutoLoad.Type = HeroAPI.self
   
   @IBOutlet var rightBarButton: UIBarButtonItem!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupTableView()
      loadData()
      Segue
         .dismissSegueFromViewController(self, triger: rightBarButton.rx_tap)
         .addDisposableTo(disposableBag)
   }
   
   deinit {
      print("\(self)")
   }
   
//   MARK:Private
   
   private func setupTableView() {
      tableView.delegate = nil
      tableView.dataSource = dataSource
   }
   
   private func loadData() {
      api.getItems(dataSource.items.count, limit: 40, search: nil,loadNextBatch: tableView.rxex_nextPageTriger)
         .map(HeroListViewModel.transform)
         .asDriver(onErrorJustReturn: [])
         .driveNext(dataSource.appendItems(.Top))
         .addDisposableTo(disposableBag)
   }
   
}

