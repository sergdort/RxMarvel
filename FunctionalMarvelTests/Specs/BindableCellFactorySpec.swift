//
//  BindableCellFactorySpec.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/30/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Quick
import Nimble

@testable import FunctionalMarvel

class BindableCellFactorySpec: QuickSpec {
   var tableView:UITableView!
   override func spec() {
      
      beforeEach { () -> () in
         self.tableView = UITableView()
      }
      
      describe("BindableCellFactorySpec") { () -> Void in
         
         it("should configure cell", closure: { () -> () in
            let vm = HeroListViewModel(hero: Hero(id: 1, name: "Hero",
               thumbnail: Thumbnail(path: "path", pathExtension: "jpg")))
            
            let cell = BindableCellFactory<HeroListViewModel>.cell(self.tableView,
               indexPath: NSIndexPath(forRow: 0, inSection: 0),
               viewModel: vm) as? HeroListTableViewCell
            
            expect(cell).toNot(beNil())
            expect(cell?.label.text).to(equal(vm.title.value))
         })
         
      }
      
   }
   
}
