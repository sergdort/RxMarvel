//
//  FunctionalMarvelTests.swift
//  FunctionalMarvelTests
//
//  Created by Segii Shulga on 10/7/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import FunctionalMarvel


class AutoLoadingSpec: QuickSpec {
   
   let bag = DisposeBag()
   let triger:PublishSubject<Void> = PublishSubject()
   var api = HeroAPI.self
   
   override func spec() {
      
      
      beforeSuite { () -> () in
         self.api.getableApi = HeroesGETMock.self
      }
      
      afterSuite { () -> () in
         self.api.getableApi = Marvel.self
      }
      
      describe("Load users") { () -> Void in
         
         it("should load users", closure: { () -> () in
            var heroes:[Hero] = []
            
            self.api
               .getItems(heroes.count, limit: 1, search: nil, loadNextBatch:self.triger)
               .subscribeNext({ (h) -> Void in
                  heroes.appendContentsOf(h)
               })
               .addDisposableTo(self.bag)
            
//            simulate next batch
            
            delay(2, closure: { () -> () in
               self.triger.onNext(())
            })
            
            expect(heroes.count)
               .toEventually(equal(2), timeout: 10)
         })
      }
   }
   
}
