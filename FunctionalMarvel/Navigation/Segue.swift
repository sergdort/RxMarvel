//
//  Segue.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/20/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum Segue {
   case ShowHeroesList
   
   var viewControllerIdentifier: String {
      switch self {
      case .ShowHeroesList:
         return "HeroListNavigationController"
      }
   }
   
   func presentationSegueFromViewController(viewController: UIViewController,
      triger: ControlEvent<Void>) -> Disposable {
      
      return triger.subscribeNext { [weak viewController] in
         if let toViewController = viewController?
            .storyboard?
            .instantiateViewControllerWithIdentifier(self.viewControllerIdentifier) {
            viewController?.presentViewController(toViewController, animated: true, completion: nil)
         }
      }
   }
   
   static func dismissSegueFromViewController(viewController: UIViewController,
      triger: ControlEvent<Void>) -> Disposable {
      return triger.subscribeNext { [weak viewController] in
         viewController?.dismissViewControllerAnimated(true, completion: nil)
      }
   }
   
}
