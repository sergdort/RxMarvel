//
//  AppendableDataSourceSpec.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 12/1/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Quick
import Nimble

@testable import FunctionalMarvel

class AppendableDataSourceSpec: QuickSpec {
   
   private class TableMock:UITableView {
      private override func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
         return self.dataSource?.tableView(self, cellForRowAtIndexPath: indexPath)
      }
   }
   
   private var tableView:TableMock!
   var dataSource:AppendableDataSource<Hero>!
   
   override func spec() {
      
      describe("AppendableDataSourceSpec") { () -> Void in
         
         beforeEach({ () -> () in
            let hero = Hero(id: 1, name: "name", thumbnail: Thumbnail(path: "path", pathExtension: "jpg"))
            self.tableView = TableMock()
            self.dataSource = AppendableDataSource(items: [hero],
               tableView: self.tableView,
               cellFactory: { (_, _, _) -> UITableViewCell in
                  return UITableViewCell()
            })
            self.tableView.dataSource = self.dataSource
         })
         
         it("should return cell", closure: { () -> () in
            let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
            expect(self.dataSource.items.count).toNot(equal(0))
            expect(cell).toNot(beNil())
         })
         
         it("should append cell", closure: { () -> () in
            let countBefor = self.dataSource.items.count
            
            let heroes = [Hero(id: 2, name: "name2", thumbnail: Thumbnail(path: "path", pathExtension: "jpg")),
                          Hero(id: 2, name: "name2", thumbnail: Thumbnail(path: "path", pathExtension: "jpg"))]
            let addedCount = heroes.count
            self.dataSource.appendItems(.None)(items: heroes)
            
            expect(self.dataSource.items.count).to(equal(countBefor + addedCount))
         })
         
         it("should have same number of items", closure: { () -> () in
            let countBefor = self.dataSource.items.count
            self.dataSource.appendItems(UITableViewRowAnimation.None)(items: [])
            expect(self.dataSource.items.count).to(equal(countBefor))
            
         })
         
      }
      
   }
   
}
