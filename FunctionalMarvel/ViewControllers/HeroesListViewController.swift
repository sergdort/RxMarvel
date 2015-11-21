//
//  ViewController.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/7/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import Alamofire
import Argo
import Runes
import RxCocoa
import RxSwift

class HeroesListViewController: RxTableViewController {
   
   let heroViewModels = Variable([HeroListViewModel]())
   
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
      tableView.dataSource = nil
      tableView.registerNib(HeroListTableViewCell.nib,
         forCellReuseIdentifier: HeroListTableViewCell.reuseIdentifier)
      tableView
         .rx_itemsWithCellFactory(heroViewModels)(cellFactory: BindableCellFactory.cell)
         .addDisposableTo(disposableBag)
   }
   
   private func loadData() {
      let nextPageTriger = Pagination.nextPageTriger(tableView)
      Marvel.heroList(heroViewModels.value.count,loadNextBatch: nextPageTriger)
         .map(HeroListViewModel.transform)
         .subscribe(onNext: { [weak self] (heroes) -> Void in
            self?.heroViewModels.value.appendContentsOf(heroes)
            },
            onError: ErrorHandler.showAlert)
         .addDisposableTo(disposableBag)
   }
   
}

