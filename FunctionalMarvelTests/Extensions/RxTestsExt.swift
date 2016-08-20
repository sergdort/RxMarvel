//
//  RxTestsExt.swift
//  FunctionalMarvel
//
//  Created by sergdort on 8/19/16.
//  Copyright © 2016 Sergey Shulga. All rights reserved.
//

import Foundation
import RxSwift
import RxTests
import RxCocoa

struct EquatableRecordedEventArray<T: Equatable>: Equatable {
    let wrapee: [Recorded<Event<[T]>>]
}

struct EquatableRecordedEvent<T: Equatable>: Equatable {
    let wrapee: [Recorded<Event<T>>]
}

func == <T: Equatable>(lhs: EquatableRecordedEvent<T>, rhs: EquatableRecordedEvent<T>) -> Bool {
    return lhs.wrapee == rhs.wrapee
}

func == <Element: Equatable>(lhs: Event<[Element]>, rhs: Event<[Element]>) -> Bool {
    switch (lhs, rhs) {
    case (.Completed, .Completed): return true
    case (.Error(let e1), .Error(let e2)):
        // if the references are equal, then it's the same object
        if let  lhsObject = lhs as? AnyObject,
            rhsObject = rhs as? AnyObject
            where lhsObject === rhsObject {
            return true
        }
        
        #if os(Linux)
            return  "\(e1)" == "\(e2)"
        #else
            let error1 = e1 as NSError
            let error2 = e2 as NSError
            
            return error1.domain == error2.domain
                && error1.code == error2.code
                && "\(e1)" == "\(e2)"
        #endif
    case (.Next(let v1), .Next(let v2)): return v1 == v2
    default: return false
    }
}

func == <T: Equatable>(lhs: [Recorded<Event<[T]>>], rhs: [Recorded<Event<[T]>>]) -> Bool {
    if lhs.count != rhs.count {
        return false
    }
    for (index, element) in lhs.enumerate() {
        if !(element == rhs[index]) {
            return false
        }
    }
    return true
}

func == <T: Equatable>(lhs: [Recorded<Event<T>>], rhs: [Recorded<Event<T>>]) -> Bool {
    if lhs.count != rhs.count {
        return false
    }
    for (index, element) in lhs.enumerate() {
        if !(element == rhs[index]) {
            return false
        }
    }
    return false
}

func == <T: Equatable>(lhs: Recorded<Event<[T]>>, rhs: Recorded<Event<[T]>>) -> Bool {
    return lhs.time == rhs.time && lhs.value == rhs.value
}

func == <T: Equatable>(lhs: EquatableRecordedEventArray<T>, rhs: EquatableRecordedEventArray<T>) -> Bool {
    return lhs.wrapee == rhs.wrapee
}
