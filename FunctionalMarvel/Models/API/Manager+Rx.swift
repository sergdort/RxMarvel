//
//  MarvelHttpClient.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 4/8/16.
//  Copyright © 2016 Sergey Shulga. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

extension Manager: HttpClient {
   func request(method: Alamofire.Method,
                _ URLString: URLStringConvertible,
                  parameters: [String: AnyObject]?,
                  encoding: ParameterEncoding,
                  headers: [String: String]? ) -> Observable<AnyObject> {
      
      return request(method, URLString,
                     parameters: parameters,
                     encoding: encoding,
                     headers: headers).rx_JSON()
   }
}
