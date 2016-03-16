//
//  ErrorHandler.swift
//  FunctionalMarvel
//
//  Created by Segii Shulga on 11/20/15.
//  Copyright © 2015 Sergey Shulga. All rights reserved.
//

import UIKit
import TSMessages

struct ErrorHandler {
    static func showAlert(err:ErrorType) {
        let error = err as NSError
        
        TSMessage.showNotificationWithTitle("Error", subtitle: error.localizedDescription, type: .Error)
    }
}
