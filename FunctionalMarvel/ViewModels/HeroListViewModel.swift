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

struct HeroListViewModel {
   
   let title: Variable<String>
   let thumbnailType = ThumbnailType.PortraitSmall
   let thumbnailURL: Variable<NSURL>
   
   init(hero: Hero) {
      self.title = Variable(hero.name)
      self.thumbnailURL = Variable(NSURL(string:hero.thumbnail.pathForType(thumbnailType))!)
   }
   
   static func transform(heroes: [Hero]) -> [HeroListViewModel] {
      return heroes.map(HeroListViewModel.init)
   }
}

extension HeroListViewModel: Hashable {
   var hashValue: Int {
      return title.value.hash ^ thumbnailURL.value.hash
   }
}

func == (lhs: HeroListViewModel, rhs: HeroListViewModel) -> Bool {
   return lhs.thumbnailURL.value == rhs.thumbnailURL.value
      && lhs.title.value == rhs.title.value
      && lhs.thumbnailType == rhs.thumbnailType
}
