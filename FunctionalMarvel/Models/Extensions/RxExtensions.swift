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

infix operator <-> {
}

infix operator <~ {

}

func <-> <T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
   let bindToUIDisposable = variable
      .bindTo(property)
   let bindToVariable = property
      .subscribe(next: { n in
         variable.value = n
         }, completed:  {
            bindToUIDisposable.dispose()
      })
   
   return StableCompositeDisposable.create(bindToUIDisposable, bindToVariable)
}

func <~ <T>(property: ObserverOf<T>, variable: Variable<T>) -> Disposable {
   return variable
      .bindTo(property)
}

extension UIImageView {
   var rx_URL:ObserverOf<NSURL> {
      return ObserverOf { [weak self] event in
         switch event {
         case .Next(let value):
            self?.sd_setImageWithURL(value, completed: { [weak self] (_, _, _, _) -> Void in
               let transition = CATransition()
               transition.duration = 0.3
               transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
               self?.layer.addAnimation(transition, forKey: kCATransition)
            })
         default:
            break
         }

      }
   }
}

