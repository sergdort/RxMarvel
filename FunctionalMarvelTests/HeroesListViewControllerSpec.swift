//
//  HeroesListViewControllerSpec.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 12/4/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Quick
import Nimble
import RxSwift

@testable import FunctionalMarvel

class HeroesListViewControllerSpec: QuickSpec {
   
   var viewController:HeroesListViewController!
   
   override func spec() {
      
      describe("HeroesListViewControllerSpec") { () -> Void in
         
         beforeEach({ () -> () in
            
            self.viewController = HeroesListViewController()
            self.viewController.api = AutoloadingAPIMock.self
            self.viewController.rightBarButton = UIBarButtonItem()
            AutoloadingAPIMock.getItems = []
            AutoloadingAPIMock.searchItems = []
            
            //force load view
            self.viewController.view.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
            
         })
         
         it("should load items", closure: { () -> () in
         
            expect(self.viewController.dataSource.items.count)
               .toEventuallyNot(equal(0))
         })
         
         it("should have cells", closure: { () -> () in
            
            expect(self.viewController.tableView
               .cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)))
               .toEventuallyNot(beNil())
            
         })
         
         it("should search items", closure: { () -> () in
            //Force search
            self.viewController.searchAdapter.searchController.searchBar.text = "text"
            self.viewController.searchAdapter
               .searchController
               .searchBar
               .delegate?
               .searchBar!(self.viewController.searchAdapter.searchController.searchBar,
                  textDidChange: "text")
            
            
            expect(self.viewController.searchAdapter.searchContentController.dataSource.items.count)
               .toEventuallyNot(equal(0))
         })
         
         it("should have cells for searched items", closure: { () -> () in
            //Force search
            self.viewController.searchAdapter.searchController.searchBar.text = "text"
            self.viewController.searchAdapter
               .searchController
               .searchBar
               .delegate?
               .searchBar!(self.viewController.searchAdapter.searchController.searchBar,
                  textDidChange: "text")
            
            expect(self.viewController
               .searchAdapter
               .searchContentController
               .tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)))
               .toEventuallyNot(beNil())
         })
         
      }
      
   }
    
}
