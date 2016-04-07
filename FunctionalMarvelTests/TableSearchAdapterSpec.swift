//
//  TableSearchAdapterSpec.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 12/3/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Quick
import Nimble
import RxSwift

@testable import FunctionalMarvel

class TableSearchAdapterSpec: QuickSpec {
   
   var adapter: TableSearchAdapter<Hero, HeroListViewModel, HeroListTableViewCell>!
   var foundHeroes: [Hero] = []
   
   override func spec() {
      
      describe("TableSearchAdapterSpec") { () -> Void in
         
         beforeEach({ () -> () in
            let dataSource: SearchTableDataSource<HeroListViewModel> =
               SearchTableDataSource(items: [],
                  cellFactory: HeroesListViewController.cellFactory)
            
            let searchController: SearchTableViewController<HeroListTableViewCell, HeroListViewModel>
               = SearchTableViewController(dataSource: dataSource)
            self.adapter = TableSearchAdapter(searchContentController: searchController,
               searchEvent: { _ -> Observable<[Hero]> in
                  return Observable.create({ (observer) -> Disposable in
                     
                     let heroes = [Hero(id: 2,
                        name: "name2",
                        thumbnail: Thumbnail(path: "path", pathExtension: "jpg")),
                        Hero(id: 2,
                           name: "name2",
                           thumbnail: Thumbnail(path: "path", pathExtension: "jpg"))]
                     
                     self.foundHeroes.appendContentsOf(heroes)
                     
                     observer.on(.Next(heroes))
                     
                     return NopDisposable.instance
                  })

               },
               viewModelMap: HeroListViewModel.transform)            
         })
         
         it("should search", closure: { () -> () in
            self.adapter.searchController.searchBar.frame =
               CGRect(x: 0, y: 0, width: 320, height: 44)
            let delegate = self.adapter.searchController.searchBar.delegate!
            
//            Force search
            delegate.searchBar!(self.adapter.searchController.searchBar, textDidChange: "Text")
            
            expect(self.adapter.searchContentController.dataSource.items.count)
               .toEventually(equal(self.foundHeroes.count))
            
            delegate.searchBar!(self.adapter.searchController.searchBar, textDidChange: "Text")
            
            expect(self.adapter.searchContentController.dataSource.items.count)
               .toEventually(equal(self.foundHeroes.count))
            
         })
         
      }
      
   }
}
