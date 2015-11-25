//
//  ModelProtocols.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/24/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import RxSwift

protocol HeroAutoLoad {
   static func getItems(offset:Int, limit:Int, search:String?, loadNextBatch:Observable<Void>) -> Observable<[Hero]>
}



protocol JsonGETable {
   static func getData(endpoint:EndPoint)(parameters:[String: AnyObject]?) -> Observable<AnyObject>
}

