//
//  HeroesGETMock.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/26/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Foundation
import RxSwift

@testable import FunctionalMarvel

struct HeroesGETMock : JsonGET {
   static func getData(endpoint: EndPoint)(parameters: [String : AnyObject]?) -> Observable<AnyObject> {
      let subject:PublishSubject<AnyObject> = PublishSubject()
      delay(1) { () -> () in
         subject.onNext(JSONFromFileName("Heroes")!)
      }
      return subject
   }
}