//
//  RemoteItemProvider.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 4/8/16.
//  Copyright © 2016 Sergey Shulga. All rights reserved.
//

import Foundation
import Argo
import RxSwift
import Alamofire

class RemoteItemProvider<T: JSONParsable> {
   
   let httpClient: HttpClient
   let paramsProvider: ParamsProvider.Type
   
   init(httpClient: HttpClient = Manager.sharedInstance, paramsProvider: ParamsProvider.Type) {
      self.httpClient = httpClient
      self.paramsProvider = paramsProvider
   }
   
   func paginateItems(batch: Batch = Batch.initial,
                      endPoint: EndPoint,
                      nextBatchTrigger: Observable<Void>) -> Observable<Page<[T]>> {
      
      let params = paramsProvider.pagingListParamsForBatch(batch)
      return httpClient
         .request(.GET, endPoint,
            parameters: paramsProvider.defaultParams + params,
            encoding: .URL,
            headers: nil)
         .map(PagingParser<T>.parse)
         .paginate(nextBatchTrigger,
                   hasNextPage: { (page) -> Bool in
                     return page.batch.next().hasNextPage
         }) { [weak self] (page) -> Observable<Page<[T]>> in
            return self?.paginateItems(page.batch.next(),
                                       endPoint: endPoint,
                                       nextBatchTrigger: nextBatchTrigger) ?? Observable.empty()
      }
   }
   
   func searchItems(query: String,
                    batch: Batch = Batch.initial,
                    endPoint: EndPoint,
                    nextBatchTrigger: Observable<Void>) -> Observable<Page<[T]>> {
      let params = paramsProvider.pagingListSearchParamsForQuery(query, batch: batch)
      
      return httpClient
         .request(.GET,
            endPoint,
            parameters: params,
            encoding: .URL,
            headers: nil)
         .map(PagingParser<T>.parse)
         .paginate(nextBatchTrigger,
                   hasNextPage: { (page) -> Bool in
                     return page.batch.next().hasNextPage
            },
                   nextPageFactory: { [weak self] (page) -> Observable<Page<[T]>> in
                     return self?.searchItems(query,
                        batch: page.batch.next(),
                        endPoint: endPoint,
                        nextBatchTrigger: nextBatchTrigger) ?? Observable.empty()
            })
    }
   
}