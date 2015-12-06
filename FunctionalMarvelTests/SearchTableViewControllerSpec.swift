//
//  SearchTableViewControllerSpec.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 12/3/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Quick
import Nimble

@testable import FunctionalMarvel

class SearchTableViewControllerSpec: QuickSpec {
   private class TableMock:UITableView {
      private override func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
         return self.dataSource?.tableView(self, cellForRowAtIndexPath: indexPath)
      }
   }
   
   private var tableView:TableMock!
   var dataSource:SearchTableDataSource<Hero>!
   
   override func spec() {
      
      describe("SearchTableViewControllerSpec") { () -> Void in
         
         beforeEach({ () -> () in
            let hero = Hero(id: 1, name: "name", thumbnail: Thumbnail(path: "path", pathExtension: "jpg"))
            self.tableView = TableMock()
            self.dataSource = SearchTableDataSource(items: [hero],
               cellFactory: { _ -> UITableViewCell in
                  return UITableViewCell()
            })
            self.tableView.dataSource = self.dataSource
         })
         
         it("should return cell", closure: { () -> () in
            
            expect(self.dataSource.items.count).toNot(equal(0))
            let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
            
            expect(cell).toNot(beNil())
         })
         
         it("should chenge items", closure: { () -> () in
            expect(self.dataSource.items.count).toNot(equal(0))
            
            let heroes = [Hero(id: 2, name: "name2", thumbnail: Thumbnail(path: "path", pathExtension: "jpg")),
               Hero(id: 2, name: "name2", thumbnail: Thumbnail(path: "path", pathExtension: "jpg"))]
            
            self.dataSource.setItems(.None, tableView: self.tableView)(items: heroes);
            
            expect(self.dataSource.items.count).to(equal(heroes.count))
         })
         
         it("should have no items", closure: { () -> () in
            expect(self.dataSource.items.count).toNot(equal(0))
            self.dataSource.setItems(UITableViewRowAnimation.None, tableView: self.tableView)(items: [])
            
            
            expect(self.dataSource.items.count).to(equal(0))
         })
         
      }
      
   }
    
}
