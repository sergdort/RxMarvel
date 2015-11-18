//
//  HeroListCellFactory.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/8/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import SDWebImage

struct HeroListCellFactory {
   
   static func cell(tableView:UITableView, index:Int, hero:HeroListViewModel) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(HeroListViewModel.cellReuseId()) as! RxTableViewCell
      cell.label.rx_text <~ hero.title
      cell.cellImageView.image = nil
      cell.cellImageView.rx_URL <~ hero.thumbnailPath
   
      return cell
   }
   
}