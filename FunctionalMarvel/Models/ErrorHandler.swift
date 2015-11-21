//
//  ErrorHandler.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/20/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit;

struct ErrorHandler {
   static func showAlert(err:ErrorType) {
      let alert = UIAlertView(title: "Error",
         message:  (err as NSError).localizedDescription,
         delegate: nil,
         cancelButtonTitle: "Dismiss")
      alert.show()
   }
}
