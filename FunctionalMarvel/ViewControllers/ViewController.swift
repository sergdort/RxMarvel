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

class ViewController: UITableViewController {
   
   let disp = DisposeBag()
   let heroViewModels = Variable([HeroListViewModel]())
   
   override func viewDidLoad() {
      super.viewDidLoad()

      setupTableView()
      loadData()
   }
   
//   MARK:Private
   
   private func setupTableView() {
      tableView.delegate = nil
      tableView.dataSource = nil
      tableView.registerNib(UINib(nibName: "RxTableViewCell", bundle: nil),
         forCellReuseIdentifier: HeroListViewModel.cellReuseId())
      tableView
         .rx_itemsWithCellFactory(heroViewModels)(cellFactory: HeroListCellFactory.cell)
         .addDisposableTo(disp)
   }
   
   private func loadData() {
      let nextPageTriger = Pagination.nextPageTriger(tableView)
      Marvel.heroList(heroViewModels.value.count,loadNextBatch: nextPageTriger)
         .map(HeroListViewModel.transform)
         .subscribe(next: { (heroes) -> Void in
            self.heroViewModels.value.appendContentsOf(heroes)
            },
            error: showAlert)
         .addDisposableTo(disp)
   }
   
   private func showAlert(err:ErrorType) {
      let alert = UIAlertView(title: "Error", message: "\(err)", delegate: nil, cancelButtonTitle: "Ok")
      alert.show()
   }
   
}

