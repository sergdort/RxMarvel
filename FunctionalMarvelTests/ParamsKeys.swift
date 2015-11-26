//
//  ParamsKeys.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/26/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Quick
import Nimble

@testable import FunctionalMarvel

class ParamsKeys: QuickSpec {
    
   override func spec() {
      
      expect(ParamKeys.apikey).to(equal("apikey"))
      expect(ParamKeys.hash).to(equal("hash"))
      expect(ParamKeys.timeStamp).to(equal("ts"))
      expect(ParamKeys.limit).to(equal("limit"))
      expect(ParamKeys.offset).to(equal("offset"))
      expect(ParamKeys.searchName).to(equal("nameStartsWith"))
      
   }
    
}
