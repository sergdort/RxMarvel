//
//  Hero.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/7/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Argo
import Curry

struct Hero {
   let id: Int
   let name: String
   let thumbnail: Thumbnail
}

extension Hero: Decodable {
   static func decode(json: JSON) -> Decoded<Hero> {
      return curry(Hero.init)
         <^> json <| "id"
         <*> json <| "name"
         <*> json <| "thumbnail"
   }
}

extension Hero: JSONParsable {
   static func parse(json: AnyObject) -> Decoded<Hero> {
      return Argo.decode(json)
   }
   static func parse(json: AnyObject) -> Decoded<[Hero]> {
      if let dict = JSONDict(json)(key: "data"),
         let array = dict["results"] {
         return Argo.decode(array)
      }
      return Decoded.Failure(DecodeError.Custom("Invalid JSON"))
   }
}
