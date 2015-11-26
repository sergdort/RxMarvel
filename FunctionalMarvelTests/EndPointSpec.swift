//
//  EndPointSpec.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/26/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Quick
import Nimble

@testable import FunctionalMarvel

class EndPointSpec: QuickSpec {
    
   override func spec() {
      
      describe("EndPointSpec") { () -> Void in
         
         it("should have correct path", closure: { () -> () in
            
            let characters = EndPoint.Characters
            
            expect(characters.path)
               .to(equal("https://gateway.marvel.com/v1/public/characters"))
            
         })
         
      }
      
   }
    
}
