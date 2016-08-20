//
//  BindableCellFactorySpec.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/30/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import XCTest
import Nimble
import RxDataSources
import RxSwift
import RxCocoa

@testable import FunctionalMarvel

class BindableCellFactoryTests: XCTestCase {
    
    
    func test_that_it_configures_cell() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        let thubnail = Thumbnail(path: "path", pathExtension: "png")
        let hero = Hero(id: 1, name: "Some Name", thumbnail: thubnail)
        let vm = HeroCellData(hero: hero)
        let section = HeroCellSection(items: [vm])
        let dataSource = RxTableViewSectionedReloadDataSource<HeroCellSection>()
        dataSource.configureCell = BindableCellFactory<HeroListTableViewCell, HeroCellData>.configureCellFromNib
        let sections = Observable.just([section])
        _ = sections.bindTo(tableView.rx_itemsWithDataSource(dataSource))
        
        let cell = dataSource.tableView(tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as? HeroListTableViewCell
        
        expect(cell) != nil
        expect(cell?.label.text) == vm.title
    }
}
