//
//  Serializer.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/7/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Foundation

enum EndPoint: String {
   static let baseURL = "https://gateway.marvel.com/v1/public/"
   
   case Characters = "characters"
   
   var path: String {
      switch self {
      case .Characters :
         return EndPoint.baseURL + self.rawValue
      }
   }
   
}
