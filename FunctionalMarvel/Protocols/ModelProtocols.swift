//
//  ModelProtocols.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/24/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import RxSwift
import Alamofire
import Argo

protocol HttpClient {
   
   func request(method: Alamofire.Method,
   _ URLString: URLStringConvertible,
   parameters: [String: AnyObject]?,
   encoding: ParameterEncoding,
   headers: [String: String]? ) -> Observable<AnyObject>
   
}

protocol JSONParsable {
   static func parse(json: AnyObject) -> Decoded<Self>
   static func parse(json: AnyObject) -> Decoded<[Self]>
}

