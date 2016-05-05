//
//  RxExtensions.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 10/7/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SDWebImage

infix operator <-> {
}

infix operator <~ {
}

infix operator ~> {
}

// Two way binding operator between control property and variable, that's all it takes {

func <-> <T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
   let bindToUIDisposable = variable.asObservable()
      .bindTo(property)
   let bindToVariable = property
      .subscribe(onNext: { n in
         variable.value = n
         },
      onCompleted: {
         bindToUIDisposable.dispose()
      })
   
   return StableCompositeDisposable.create(bindToUIDisposable, bindToVariable)
}

// One way binding operator

func <~ <T>(property: AnyObserver<T>, variable: Variable<T>) -> Disposable {
   return variable.asObservable()
      .bindTo(property)
}

func ~> <T>(variable: Variable<T>, property: AnyObserver<T>) -> Disposable {
   return variable.asObservable()
      .bindTo(property)
}

extension UIImageView {
   var rxex_imageURL: AnyObserver<NSURL> {
      return AnyObserver { [weak self] event in
         switch event {
         case .Next(let value):
            self?.image = nil
            self?.sd_setImageWithURL(value, completed: { [weak self] _ in
               let transition = CATransition()
               transition.duration = 0.3
               transition.timingFunction =
                  CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
               self?.layer.addAnimation(transition, forKey: kCATransition)
            })
         default:
            break
         }

      }
   }
}

extension UITableView {
   var rx_nextPageTriger: Observable<Void> {
      return self
         .rx_contentOffset
         .flatMapLatest { [weak self] (offset) -> Observable<Void> in
            let shouldTriger = offset.y + (self?.frame.size.height ?? 0) + 40 > (self?.contentSize.height ?? 0)
            return shouldTriger ? Observable.just() : Observable.empty()
      }
   }
}
