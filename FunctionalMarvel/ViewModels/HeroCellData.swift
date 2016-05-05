//
//  HeroListViewModel.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/8/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct HeroCellData {
   
   let title: String
   let thumbnailType = ThumbnailType.PortraitSmall
   let thumbnailURL: NSURL
   
   init(hero: Hero) {
      title = hero.name
      thumbnailURL = NSURL(string:hero.thumbnail.pathForType(thumbnailType))!
   }
   
   static func transform(heroes: [Hero]) -> [HeroCellData] {
      return heroes.map(HeroCellData.init)
   }
}

extension HeroCellData: Hashable {
   var hashValue: Int {
      return title.hash ^ thumbnailURL.hash
   }
}

func == (lhs: HeroCellData, rhs: HeroCellData) -> Bool {
   return lhs.thumbnailURL == rhs.thumbnailURL
      && lhs.title == rhs.title
      && lhs.thumbnailType == rhs.thumbnailType
}
