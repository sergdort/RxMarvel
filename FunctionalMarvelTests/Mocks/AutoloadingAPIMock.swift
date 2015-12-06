//
//  AutoloadingAPIMock.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 12/4/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import RxSwift

@testable import FunctionalMarvel

struct AutoloadingAPIMock:HeroAutoLoading {
   
   static var getItems = [Hero]()
   static var searchItems = [Hero]()
   
   static func getItems(offset:Int,
      limit:Int,
      loadNextBatch:Observable<Void>) -> Observable<[Hero]> {
         return create({ (observer) -> Disposable in
            
            let heroes = [Hero(id: 2, name: "name2", thumbnail: Thumbnail(path: "path", pathExtension: "jpg")),
               Hero(id: 2, name: "name2", thumbnail: Thumbnail(path: "path", pathExtension: "jpg"))]
            
            self.getItems.appendContentsOf(heroes)
            
            observer.on(.Next(heroes))
            
            return NopDisposable.instance
         })
   }
   
   
   static func searchItems(offset:Int,
      limit:Int,
      search:String,
      loadNextBatch:Observable<Void>) -> Observable<[Hero]> {
         return create({ (observer) -> Disposable in
            
            let heroes = [Hero(id: 2, name: "name2", thumbnail: Thumbnail(path: "path", pathExtension: "jpg")),
               Hero(id: 2, name: "name2", thumbnail: Thumbnail(path: "path", pathExtension: "jpg"))]
            
            self.searchItems.appendContentsOf(heroes)
            
            observer.on(.Next(heroes))
            
            return NopDisposable.instance
         })

   }
   
}
