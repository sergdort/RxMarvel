//
//  DataSourceSpec.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/30/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Quick
import Nimble
import UIKit

@testable import FunctionalMarvel

class DataSourceSpec: QuickSpec {
   let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 300), style:.Plain)
   var dataSource:AppendableDataSource<HeroListViewModel>!
   
   override func spec() {
      
      beforeEach { () -> () in
         let heroes = [Hero(id: 1, name: "Hero", thumbnail: Thumbnail(path: "path", pathExtension: "jpg"))]
         self.dataSource = AppendableDataSource(items: heroes.map(HeroListViewModel.init),
            tableView: self.tableView,
            cellFactory: { (_, _, _) -> UITableViewCell in
               return UITableViewCell()
         })
         self.tableView.dataSource = self.dataSource
         self.tableView.reloadData()
      }
      
      describe("Appendeble datasource") { () -> Void in
         
         it("should return cell", closure: { () -> () in
         
            let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))

            expect(cell).toNot(beNil())
         })
         
         it("should add itme to datasource", closure: { () -> () in
            expect(self.dataSource.items.count).to(equal(1))
            
            let heroes = [Hero(id: 1, name: "Hero2", thumbnail: Thumbnail(path: "path", pathExtension: "jpg"))]
            self.dataSource.appendItems(.None)(items: heroes.map(HeroListViewModel.init))
            
            expect(self.dataSource.items.count).to(equal(2))
         })
         
      }
   }
    
}
