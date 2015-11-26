//
//  DecodeSpec.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/26/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Quick
import Nimble
import Argo
import Runes

@testable import FunctionalMarvel

class DecodeSpec: QuickSpec {

   override func spec() {
      
      describe("Decode") { () -> Void in
         
         it("should decode hero", closure: { () -> () in
         
            let hero:Hero? = decode -<< (JSONFromFileName -<< "Hero")
            
            expect(hero).toNot(beNil())
            expect(hero?.id).to(equal(1011334))
            expect(hero?.name).to(equal("3-D Man"))
            expect(hero?.thumbnail).toNot(beNil())
            expect(hero?.thumbnail.path).to(equal("http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"))
            expect(hero?.thumbnail.pathExtension).to(equal("jpg"))
         })
         
         it("should decode batch", closure: { () -> () in
            let batch:Batch? = decode -<< (JSONFromFileName -<< "Batch")
            
            expect(batch).toNot(beNil())
            expect(batch?.count).to(equal(1))
            expect(batch?.offset).to(equal(0))
            expect(batch?.limit).to(equal(1))
            expect(batch?.total).to(equal(1485))
         })
         
      }
      
   }

}
