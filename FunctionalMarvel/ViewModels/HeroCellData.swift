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
import RxDataSources

struct HeroCellSection: AnimatableSectionModelType {
    typealias Item = HeroCellData
    
    var items: [Item]
    var title: String = "Heroes"
    
    var identity: String {
        return title
    }
    
    init(items: [Item]) {
        self.items = items
    }
    
    init(original: HeroCellSection, items: [Item]) {
        self.items = items
        self.title = original.title
    }
}

struct HeroCellData: IdentifiableType {
    
    let title: String
    let thumbnailType = ThumbnailType.PortraitSmall
    let thumbnailURL: NSURL
    let identity: Int
    
    init(hero: Hero) {
        identity = hero.id
        title = hero.name
        thumbnailURL = NSURL(string:hero.thumbnail.pathForType(thumbnailType)) ?? NSURL()
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
