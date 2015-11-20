//
//  MarvelService.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/7/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import Runes
import Argo



struct Marvel {
   
   private static let formatter:NSDateFormatter = {
      let f = NSDateFormatter()
      f.dateFormat = "yyyyMMddHHmmss"
      return f
      }()
   
   private static let decodeScheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "com.FunctionalMarvel.decode_queue")
   
   private static var defaultParams:[String:AnyObject] {
      let timeStamp = formatter.stringFromDate(NSDate())
      let hash = "\(timeStamp)\(Keys.privatKey)\(Keys.publicKey)".md5()
      
      return [
         ParamKeys.apikey : Keys.publicKey,
         ParamKeys.hash : hash,
         ParamKeys.timeStamp : timeStamp
      ]
   }
   
   private static func heroListSignal(params:[String:AnyObject]? = nil) -> Observable<(heroes:Decoded<[Hero]>, batch:Decoded<Batch>)> {
      
      return Alamofire
         .request(
            .GET,
            EndPoint.Characters.path(),
            parameters: self.defaultParams + (params ?? [:]))
         .rx_responseJSON()
         .observeOn(decodeScheduler)
         .map(HeroDecoder.decode)
         .observeOn(MainScheduler.sharedInstance)
   }
   
   static func heroListSignal(offset:Int = 0, limit:Int = 10, nameSearch:String? = nil) -> Observable<(heroes:Decoded<[Hero]>, batch:Decoded<Batch>)> {
      print(offset)
      
      let params:[String : AnyObject] = [ ParamKeys.limit : limit, ParamKeys.offset : String(offset)] + (nameSearch != nil ? [ParamKeys.searchName : nameSearch!] : [:])
      
      return heroListSignal(params)
   }
   
   static func recursiveHeroList(offset:Int = 0, loadNextBatch:Observable<Void>) -> Observable<[Hero]>  {
      return
         heroListSignal(offset)
            .flatMap { (tuple) -> Observable<[Hero]>  in
               
               guard let heroes = tuple.heroes.value,
                     let batch = tuple.batch.value  else {
                  return empty()
               }
               
               if batch.offset == batch.total
                  || batch.offset + batch.count == batch.total {
//                     Here we've downloaded all data
                  return empty()
               }
               
               return [
                  just(heroes),
                  never().takeUntil(loadNextBatch),
                  recursiveHeroList(batch.count + batch.offset, loadNextBatch: loadNextBatch)
                  ].concat()
         }
   }
   
   static func heroList(offset:Int = 0, loadNextBatch:Observable<Void>) -> Observable<[Hero]> {
      return recursiveHeroList(offset, loadNextBatch: loadNextBatch)
   }
}

extension Marvel {
   private struct ParamKeys {
      static let apikey = "apikey"
      static let hash = "hash"
      static let timeStamp = "ts"
      static let limit = "limit"
      static let offset = "offset"
      static let searchName = "nameStartsWith"
   }
   
   private struct Keys {
      static let privatKey = "9597bcd0e2339d5874d9913140b581ed0b55a921"
      static let publicKey = "be23153c199affa766dc9fe6f34fd524"
   }
   
   private struct HeroDecoder {
      static func decode(j:AnyObject) -> (heroes:Decoded<[Hero]>, batch:Decoded<Batch>) {
         if let dict = JSONDict(j)(key: "data"),
            let array = dict["results"] {
               return (Argo.decode(array), Argo.decode(dict))
         }
         return (Decoded.Failure(DecodeError.Custom("Invalid JSON")), Decoded.Failure(DecodeError.Custom("Invalid JSON")))
      }
   }
   
}



