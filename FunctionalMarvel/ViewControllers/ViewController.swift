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
      loadDataSignal()
         .subscribe(next: { (heroes) -> Void in
            self.heroViewModels.value.appendContentsOf(heroes)
            print("items = \(self.heroViewModels.value.count)")
            }, error: showAlert
            , disposed: { () -> Void in
               print("disposed")
         }).addDisposableTo(disp)
   }
   
   private func loadDataSignal() -> Observable<[HeroListViewModel]> {
      let nextPageTriger = Pagination.nextPageTriger(tableView)
      return Marvel.heroList(heroViewModels.value.count,loadNextBatch: nextPageTriger)
         .map(HeroListViewModel.transform)
         .catchError({ (_) in
            self.loadDataSignal()
         })
   }
   
   private func showAlert(err:ErrorType) {
      let alert = UIAlertView(title: "Error", message: "\(err)", delegate: nil, cancelButtonTitle: "Ok")
      alert.show()
   }
   
}

