//
//  ViewController.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/20/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit

class ViewController: RxViewController {

   @IBOutlet var button: UIButton!
   
   override func viewDidLoad() {
      Segue
         .ShowHeroesList
         .presentationSegueFromViewController(self, triger: button.rx_tap)
         .addDisposableTo(disposableBag)
   }
   
}
