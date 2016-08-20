//
//  HereListViewModelTests.swift
//  FunctionalMarvel
//
//  Created by sergdort on 8/15/16.
//  Copyright © 2016 Sergey Shulga. All rights reserved.
//

import XCTest
import Nimble
import RxSwift
import RxCocoa
import RxTests

@testable import FunctionalMarvel

extension HeroCellSection: Equatable {
}

func == (lhs: HeroCellSection, rhs: HeroCellSection) -> Bool {
    return lhs.identity == rhs.identity
        && lhs.title == rhs.title
        && lhs.items == rhs.items
}

class HeroListViewModelTests: XCTestCase {
    
    func test_that_it_emits_correct_sections() {
        let scheduler = TestScheduler(initialClock: 0,
                                      resolution: TestScheduler.defaultResolution,
                                      simulateProcessingDelay: false)
        
        //TimeLines
        let pagingTimeLine = "--1---2---------------------------"
        let dismissTimeLine = "----------------------------------------1"
        let expectedSectionsTimeLine = "1-2---3----------------------------------"
        
        //Values
        let paging = [
            "1" : (),
            "2" : (),
            ]
        
        
        let dismiss = [
            "1" : ()
        ]
        let sections = [
            "1" : [HeroCellSection(items:HeroApiMock.sampleHeroes.map(HeroCellData.init))],
            "2" : [HeroCellSection(items:(HeroApiMock.sampleHeroes + HeroApiMock.sampleHeroes).map(HeroCellData.init))],
            "3" : [HeroCellSection(items:(HeroApiMock.sampleHeroes + HeroApiMock.sampleHeroes + HeroApiMock.sampleHeroes
                ).map(HeroCellData.init))],
            ]
        //Events
        let pageEvents = scheduler.parseEventsAndTimes(pagingTimeLine, values: paging).first!
        let dismissEvents = scheduler.parseEventsAndTimes(dismissTimeLine, values: dismiss).first!
        let expectedSectionsEvents = scheduler.parseEventsAndTimes(expectedSectionsTimeLine,
                                                                   values: sections).first!
        
        let input = HeroListViewModel.Input(searchQuery: Observable.empty(),
                                            nextPageTrigger: scheduler.createHotObservable(pageEvents).asObservable(),
                                            searchNextPageTrigger: Observable.empty(),
                                            dismissTrigger: scheduler.createHotObservable(dismissEvents).asDriver(onErrorJustReturn: ()))
        
        let viewModel = HeroListViewModel(input: input,
                                          api: HeroApiMock(), scheduler: scheduler)
        
        driveOnScheduler(scheduler) {
            let recordedSections = scheduler.record(viewModel.mainTableItems)
            
            scheduler.start()
            
            let wrappedResultRecords = EquatableRecordedEventArray(wrapee: recordedSections.events)
            let wrappedExpectedRecords = EquatableRecordedEventArray(wrapee: expectedSectionsEvents)
            
            expect(wrappedResultRecords) == wrappedExpectedRecords
        }
    }
    
    func test_that_it_emits_correct_searched_sections() {
        let scheduler = TestScheduler(initialClock: 0,
                                      resolution: TestScheduler.defaultResolution,
                                      simulateProcessingDelay: false)
        //TimeLines
        let searchTimeLine = "----------1------2------3------4---------"
        let searchPagingTimeLine = "----------------------1------2-----------"
        let expectedSearchTimeLine = "--------------------1-2----3-4----5------"
        
        //Values
        let doubleA = [HeroCellSection(items:HeroApiMock.searchHeroesSamples["a"]!.map(HeroCellData.init) + HeroApiMock.searchHeroesSamples["a"]!.map(HeroCellData.init))]
        let doubleAA = [HeroCellSection(items:HeroApiMock.searchHeroesSamples["aa"]!.map(HeroCellData.init) + HeroApiMock.searchHeroesSamples["aa"]!.map(HeroCellData.init))]
        
        let search = [
            "1" : "",
            "2" : "a",
            "3" : "aa",
            "4" : "a"
        ]
        let paging = [
            "1" : (),
            "2" : (),
            ]
        let sections = [
            "1" : [HeroCellSection(items:HeroApiMock.searchHeroesSamples["a"]!.map(HeroCellData.init))],
            "2" : doubleA,
            "3" : [HeroCellSection(items:HeroApiMock.searchHeroesSamples["aa"]!.map(HeroCellData.init))],
            "4" : doubleAA,
            "5" : [HeroCellSection(items:HeroApiMock.searchHeroesSamples["a"]!.map(HeroCellData.init))],
        ]

        let searchEvents = scheduler.parseEventsAndTimes(searchTimeLine, values: search).first!
        let pagingEvents = scheduler.parseEventsAndTimes(searchPagingTimeLine,
                                                               values: paging).first!
        let correctSectionRecords = scheduler.parseEventsAndTimes(expectedSearchTimeLine,
                                                                         values: sections).first!
        
        let input = HeroListViewModel.Input(searchQuery: scheduler.createHotObservable(searchEvents).asObservable(),
                                            nextPageTrigger: Observable.empty(),
                                            searchNextPageTrigger: scheduler.createHotObservable(pagingEvents).asObservable(),
                                            dismissTrigger: Driver.empty())
        
        let viewModel = HeroListViewModel(input: input,
                                          api: HeroApiMock(), scheduler: scheduler)
        
        driveOnScheduler(scheduler) {
            let recoredSections = scheduler.record(viewModel.searchTableItems)

            scheduler.start()
            
            let wrappedResultRecords = EquatableRecordedEventArray(wrapee: recoredSections.events)
            let wrappedExpectedRecords = EquatableRecordedEventArray(wrapee: correctSectionRecords)
            expect(wrappedResultRecords) == wrappedExpectedRecords
        }
    }
}

extension HeroListViewModelTests {
    private class HeroApiMock: HeroAPI {
        static let sampleHeroes = [
            Hero(id: 1, name: "Aaron Stack", thumbnail: Thumbnail(path: "", pathExtension: "png")),
            Hero(id: 1, name: "Abomination", thumbnail: Thumbnail(path: "", pathExtension: "png"))
        ]
        
        static let searchHeroesSamples = [
            "a" : [
                Hero(id: 1, name: "Aaron Stack", thumbnail: Thumbnail(path: "", pathExtension: "png")),
                Hero(id: 1, name: "Abomination", thumbnail: Thumbnail(path: "", pathExtension: "png"))
            ],
            "aa": [
                Hero(id: 1, name: "Aaron Stack", thumbnail: Thumbnail(path: "", pathExtension: "png"))
            ]
        ]
        
        func paginateItems(batch: Batch,
                           endPoint: EndPoint,
                           nextBatchTrigger: Observable<Void>) -> Observable<[Hero]> {
            
            return recursivelyPaginateItems(batch, endPoint: endPoint, nextBatchTrigger: nextBatchTrigger)
                .scan([]) {
                    return $0.0 + $0.1
            }
        }
        
        private func recursivelyPaginateItems(batch: Batch,
                                              endPoint: EndPoint,
                                              nextBatchTrigger: Observable<Void>) -> Observable<[Hero]> {
            let heroes = HeroApiMock.sampleHeroes
            return Observable.just(heroes)
                .paginate(nextBatchTrigger,
                          hasNextPage: { (_) -> Bool in
                            return true
                    }, nextPageFactory: { [weak self] (_) -> Observable<[Hero]> in
                        return self?.recursivelyPaginateItems(batch, endPoint: endPoint, nextBatchTrigger: nextBatchTrigger) ?? Observable.empty()
                    })
        }
        
        func searchItems(query: String,
                         batch: Batch,
                         endPoint: EndPoint,
                         nextBatchTrigger: Observable<Void>) -> Observable<[Hero]> {
            return recursivelySearch(query,
                batch: batch,
                endPoint: endPoint,
                nextBatchTrigger: nextBatchTrigger)
                .scan([]) {
                    return $0.0 + $0.1
            }
        }
        
        private func recursivelySearch(query: String,
                                       batch: Batch = Batch.initial,
                                       endPoint: EndPoint,
                                       nextBatchTrigger: Observable<Void>) -> Observable<[Hero]> {
            
            let heroes = HeroApiMock.searchHeroesSamples[query] ?? []
            return Observable.just(heroes)
                .paginate(nextBatchTrigger,
                          hasNextPage: { (_) -> Bool in
                            return true
                    },
                          nextPageFactory: { [weak self] (_) -> Observable<[Hero]> in
                            return self?.recursivelySearch(query,
                                batch: batch,
                                endPoint: endPoint,
                                nextBatchTrigger: nextBatchTrigger) ?? Observable.empty()
                    })
        }
        
    }

}
